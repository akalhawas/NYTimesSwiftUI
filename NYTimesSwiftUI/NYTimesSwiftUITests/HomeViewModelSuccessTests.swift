//
//  HomeViewModelSuccessTests.swift
//  NYTimesSwiftUITests
//
//  Created by ali alhawas on 25/10/1445 AH.
//

import XCTest
@testable import NYTimesSwiftUI

final class HomeViewModelSuccessTests: XCTestCase {

    var articleAPIService: ArticleServiceImpSuccessMock!
    var vm: HomeViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Gevin
        articleAPIService = ArticleServiceImpSuccessMock()
        vm = HomeViewModel(articleAPIService: articleAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        articleAPIService = nil
        vm = nil
    }

    func test_HomeViewModel_download_with_successful_response_articles() async throws {
        // Before
        XCTAssertFalse(vm.isLoading, "The view model should not be loading viewState has to be nil at start")
        XCTAssertFalse(vm.isFinished, "The view model should be finished")
        XCTAssertFalse(vm.didReset, "The view model didReset should be false")
        
        // After
        defer {
            XCTAssertFalse(vm.isLoading, "The view model should not be loading it has to be finished")
            XCTAssertTrue(vm.isFinished, "The view model should be finished")
            XCTAssertTrue(vm.didReset, "The view model didReset should be true")
            XCTAssertFalse(vm.hasError, "The hasError should be false")
            XCTAssertNil(vm.error, "The error should be nil")
        }
        
        // When
        await vm.fetchArticles()
        
        // Then
        let articles = try NYLocalFileDecoder.decode(file: "ArticleData", type: ArticleResponse.self).results
        XCTAssertNotNil(vm.articles, "The articles in the view model should not be nil")
        XCTAssertGreaterThan(vm.articles.count, 0, "The article in the view model should return value")
        XCTAssertEqual(vm.articles.count, articles.count, "The response from our MockArticleAPIServiceImp should match")
    }
}
