//
//  HomeViewModelFailureTests.swift
//  NYTimesSwiftUITests
//
//  Created by ali alhawas on 25/10/1445 AH.
//

import XCTest
@testable import NYTimesSwiftUI

final class HomeViewModelFailureTests: XCTestCase {

    var articleAPIService: ArticleServiceImpFailureMock!
    var vm: HomeViewModelImp!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Gevin
        articleAPIService = ArticleServiceImpFailureMock()
        vm = HomeViewModelImp(articleAPIService: articleAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        articleAPIService = nil
        vm = nil
    }

    func test_HomeViewModel_download_with_successful_response_articles() async throws {
        // Check isLoading before and after
        XCTAssertFalse(vm.isLoading, "The view model should not be loading at start")
        XCTAssertFalse(vm.isFinished, "The view model should be finished")
        XCTAssertFalse(vm.didReset, "The view model should be false")
        
        defer {
            XCTAssertFalse(vm.isLoading, "The view model should not be loading at the end")
            XCTAssertTrue(vm.isFinished, "The view model should be finished")
            XCTAssertTrue(vm.didReset, "The view model should be true")
        }
 
        // When
        await vm.fetchArticles()
        
        // Then
        XCTAssertTrue(vm.hasError, "The view model error should be true so it does throw an error")
        XCTAssertNotNil(vm.error, "The view model error should not be nil")
        XCTAssertEqual(vm.error, NetworkingError.failedToDecode, "The error should match")
    }
}

