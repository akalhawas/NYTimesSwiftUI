//
//  HomeViewModel_Tests.swift
//  NYTimesSwiftUITests
//
//  Created by ali alhawas on 15/10/1445 AH.
//

import XCTest
import Combine
@testable import NYTimesSwiftUI

final class HomeViewModel_Tests: XCTestCase {

    var vm: HomeViewModel?
    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = HomeViewModel(articleAPIService: ArticleAPIServiceImp())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
    }
    
    /// - Note: This will test if addSubscribers with MockArticleAPIServiceImp  will return Data
    /// using wait and expectation to fix that the moment $articles get published have to call expectation.fulfill()
    func test_HomeViewModel_download_shouldReturnItems()  {
        // Gevin
        let articles = [DeveloperPreview.instance.article]
        let articleAPIService: ArticleAPIService = MockArticleAPIServiceImp(articles: articles)
        let vm = HomeViewModel(articleAPIService: articleAPIService)
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 second")
        
        vm.$articles
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill() // < $articles get published so call expectation
            }
            .store(in: &cancellable)
        
        vm.addSubscribers()
        
        // Then
        wait(for: [expectation], timeout: 3) 
        XCTAssertGreaterThan(vm.articles.count, 0) // if return value
        XCTAssertEqual(vm.articles.count, articles.count) // if return the exact count
    }


}
