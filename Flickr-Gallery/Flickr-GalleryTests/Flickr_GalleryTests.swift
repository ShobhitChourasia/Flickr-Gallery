//
//  Flickr_GalleryTests.swift
//  Flickr-GalleryTests
//
//  Created by Shobhit on 22/05/21.
//

import XCTest
@testable import Flickr_Gallery

class Flickr_GalleryTests: XCTestCase {

    var viewModel: GalleryViewModelProtocol!
    
    //NOTE: Please update time out if test case fails.
    //It may due to the fact that, due to low network, response was not received within 5 seconds.
    static let responseTimeout: TimeInterval = 5 // in seconds
    
    override func setUpWithError() throws {
        viewModel = GalleryViewModel()
        viewModel.currentPageNumber = 1
        viewModel.perPageResultCount = 1
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

}

extension Flickr_GalleryTests {
 
    // Tests API for empty text search
    func testEmptyTextSearch() {
        viewModel.searchText = ""
        XCTAssertFalse(viewModel.checkIfSearchQueryIsValid())
        
        viewModel.searchText = "   "
        XCTAssertFalse(viewModel.checkIfSearchQueryIsValid())
    }
    
    // Tests API for non empty text search
    func testNonEmptyTextSearch() {
        viewModel.searchText = "kittens"
        XCTAssertTrue(viewModel.checkIfSearchQueryIsValid())
        
        viewModel.searchText = "cute kittens"
        XCTAssertTrue(viewModel.checkIfSearchQueryIsValid())
    }
    
    // Tests API for valid text search
    func testValidTestResults() {
        viewModel.searchText = "kittens"

        let resultExpectation = expectation(description: "Valid request with result!")
        viewModel.getImages { (response) in
            XCTAssertNotNil(response)
            XCTAssertTrue(response?.photos?.currentPage == 1)
            XCTAssertTrue(response?.photos?.total ?? 0 > 0)
            XCTAssertTrue(response?.photos?.allPhotos.count ?? 0 > 0)
            resultExpectation.fulfill()
        }
        
        waitForExpectations(timeout: Self.responseTimeout, handler: nil)
    }
    
    // Tests API for invalid text search
    func testEmptyTestResults() {
        viewModel.searchText = "xcasdkjajkdhahdjhadjk"

        let resultExpectation = expectation(description: "Valid request with no result!")
        viewModel.getImages { (response) in
            XCTAssertNotNil(response)
            XCTAssertTrue(response?.photos?.currentPage == 1)
            XCTAssertTrue(response?.photos?.total == 0)
            XCTAssertTrue(response?.photos?.allPhotos.count ?? 0 == 0)
            resultExpectation.fulfill()
        }
        
        waitForExpectations(timeout: Self.responseTimeout, handler: nil)
    }
    
    func testIfPageNumberResetsCorrectly() {
        viewModel.currentPageNumber = 100
        
        viewModel.resetPageNumber()
        
        XCTAssertTrue(viewModel.currentPageNumber == 1)
        XCTAssert(viewModel.allPhotos.count == 0)
    }
}
