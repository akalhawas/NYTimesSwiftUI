//
//  MockArticleAPIServiceImp_Tests.swift
//  NYTimesSwiftUITests
//
//  Created by ali alhawas on 15/10/1445 AH.
//

import XCTest
@testable import NYTimesSwiftUI
import Combine

final class MockArticleAPIServiceImp_Tests: XCTestCase {

    var cancelanles = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancelanles.removeAll()
    }

    func test_MockArticleAPIServiceImp_init_doesSetValuesCorrectly() {
        // Gevin
        let articles: [ArticleModel]? = nil
        let articles2: [ArticleModel]? = []
        let articles3: [ArticleModel]? = [DeveloperPreview.instance.article, DeveloperPreview.instance.article]
        
        // When
        let articleServices = MockArticleAPIServiceImp(articles: articles)
        let articleServices2 = MockArticleAPIServiceImp(articles: articles2)
        let articleServices3 = MockArticleAPIServiceImp(articles: articles3)
        
        // Then
        XCTAssertFalse(articleServices.articles.isEmpty) // it should not be empty
        XCTAssertTrue(articleServices2.articles.isEmpty) // it should be empty
        XCTAssertEqual(articleServices3.articles.count, articles3?.count) // it should be equal
    }
    
    func test_MockArticleAPIServiceImp_downloadArticles_doesReturnValues() {
        // Gevin
        let articleService = MockArticleAPIServiceImp(articles: nil) // nil so it will has the default value
        
        // When
        var articles: [ArticleModel] = []
        let expectation = XCTestExpectation()
        
        articleService.fetchArticle()
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure:
                        XCTFail()
                }
            } receiveValue: { returnedArticles in
                articles = returnedArticles
            }
            .store(in: &cancelanles)

        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(articles.count, articleService.articles.count) // it will return value and it will be equal
    }
    
    func test_MockArticleAPIServiceImp_downloadArticles_doesFail() {
        // Gevin
        let articleService = MockArticleAPIServiceImp(articles: []) // empty so it should throw error and it should be invalidData
        
        // When
        var articles: [ArticleModel] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw an URLReeoe.badServerResponse")
        
        articleService.fetchArticle()
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTFail()
                    case .failure(let error):
                        expectation.fulfill()
                        
                        let urlError = error as? NetworkingManager.NetworkingError
                        XCTAssertEqual(urlError, NetworkingManager.NetworkingError.invalidData)
                        
                        if urlError == NetworkingManager.NetworkingError.invalidData {
                            expectation2.fulfill()
                        }
                }
            } receiveValue: { returnedArticles in
                articles = returnedArticles
            }
            .store(in: &cancelanles)

        
        // Then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(articles.count, articleService.articles.count)
    }
}
