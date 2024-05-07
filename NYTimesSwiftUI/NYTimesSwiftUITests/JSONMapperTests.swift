//
//  JSONMapperTests.swift
//  NYTimesSwiftUITests
//
//  Created by ali alhawas on 25/10/1445 AH.
//

import XCTest
@testable import NYTimesSwiftUI

final class JSONMapperTests: XCTestCase {

    func test_with_valid_json_successfully_decodes() {
        
        XCTAssertNoThrow(try NYLocalFileDecoder.decode(file: "ArticleData", type: ArticleResponse.self), "Mapper shouldn't throw an error")
        
        let userResponse = try? NYLocalFileDecoder.decode(file: "ArticleData", type: ArticleResponse.self)
        
        XCTAssertNotNil(userResponse, "User response shouldn't be nil")
        XCTAssertEqual(userResponse?.results.count, 1, "The total number of users should be 1")
        XCTAssertEqual(userResponse?.results[0].id, 100000009441438, "The id should be 100000009441438")
        XCTAssertEqual(userResponse?.results[0].title, "How Protesters Can Actually Help Palestinians", "The title should be How Protesters Can Actually Help Palestinians")
        XCTAssertEqual(userResponse?.results[0].abstract, "I worry that the more aggressive demonstrators may be hurting the Gazans they’re trying to support.", "The abstract should be I worry that the more aggressive demonstrators may be hurting the Gazans they’re trying to support.")
        XCTAssertEqual(userResponse?.results[0].byline, "By Nicholas Kristof", "The byline should be By Nicholas Kristof")
        XCTAssertEqual(userResponse?.results[0].section, "Opinion", "The section should be Opinion")
        XCTAssertEqual(userResponse?.results[0].source, "New York Times", "The source should be New York Times")
        XCTAssertEqual(userResponse?.results[0].type, "Article", "The type should be Article")
        XCTAssertEqual(userResponse?.results[0].updated, "2024-05-02 12:35:49", "The updated should be 2024-05-02 12:35:49")
    }

    func test_with_missing_file_error_thrown() {
        XCTAssertThrowsError(try NYLocalFileDecoder.decode(file: "", type: ArticleResponse.self), "An error should be thrown")
        do {
            _ = try NYLocalFileDecoder.decode(file: "", type: ArticleResponse.self)
        } catch {
            guard let mappingError = error as? NetworkingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, NetworkingError.failedToDecode, "This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_file_error_thrown() {
        XCTAssertThrowsError(try NYLocalFileDecoder.decode(file: "xasd", type: ArticleResponse.self), "An error should be thrown")
        do {
            _ = try NYLocalFileDecoder.decode(file: "asxd", type: ArticleResponse.self)
        } catch {
            guard let mappingError = error as? NetworkingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, NetworkingError.failedToDecode, "This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_json_error_thrown() {
        XCTAssertThrowsError(try NYLocalFileDecoder.decode(file: "SingleArticleData", type: ArticleResponse.self), "An error should be thrown")
        do {
            _ = try NYLocalFileDecoder.decode(file: "SingleArticleData", type: ArticleResponse.self)
        } catch {
            if error is NetworkingError {
                XCTFail("Got the wrong type of error, expecting a system decoding error")
            }
        }
    }
}
