//
//  NASAAppTests.swift
//  NASAAppTests
//
//  Created by Ludovik on 14/04/2021.
//

import XCTest
import RxSwift


class NASAAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    func testItemService(){
        
        let service = NasaItemService()
        
        let itemParseExpectation = expectation(description: "itemFetch")
        var items: [NasaItem]?
        var nextUrl: String?
        service.fetchNasaItems(NextUrl: nil) { (its, nUrl) in
            items = its
            nextUrl = nUrl
            itemParseExpectation.fulfill()
        } failure: { (error) in
            itemParseExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNotNil(items)
            XCTAssertNotNil(nextUrl)
            
            if let item = items?.first {
                self.nasaItemCheck(item)
                self.imageCollectionForItem(item)
            }
          }
    }
    
    private func nasaItemCheck(_ item: NasaItem){
        XCTAssertNotNil(item.date_created)
        XCTAssertNotNil(item.description)
        XCTAssertNotNil(item.thumbImageUrl)
        XCTAssertNotNil(item.nasa_id)
        XCTAssertNotNil(item.title)
        XCTAssertNotNil(item.imageCollectionUrl)
        
        
    }
    
    private func imageCollectionForItem(_ item: NasaItem){
        let service = NasaItemService()
        let itemCollectionFetchExpectation = expectation(description: "imageCollectionFetch")
        var imageUrl: String?
        service.fetchImageCollection(ForItem: item) { (collectionUrl) in
            imageUrl = collectionUrl
            itemCollectionFetchExpectation.fulfill()
        } failure: { (error) in
            itemCollectionFetchExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNotNil(imageUrl)
            XCTAssertNotNil(URL(string: imageUrl ?? ""))
          }
    }
    
   
    func testItemListViewControllerViewModel() throws {
        let expectation = self.expectation(description: "ItemListViewControllerViewModel")
        let recorder = Recorder<NASAItemListViewControllerTableViewCellViewModel>()
        let recorderLoaing = Recorder<Bool>()
        let viewModel = NASAItemListViewControllerViewModel()
        recorder.on(arraySubject: viewModel.nasaItems)
        recorderLoaing.on(valueSubject: viewModel.isLoading)
        viewModel.refreshItems()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5, execute: {
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertTrue(recorder.items.count > 0)
            XCTAssertFalse(recorderLoaing.items.last ?? true)
        }
    }
    
    
    func testItemListViewControllerTableViewCellViewModel(){
        let item = NasaItem()
        item.date_created = "2002-03-20T00:00:00Z"
        let viewModel = NASAItemListViewControllerTableViewCellViewModel.init(nasaItem: item)
        XCTAssertEqual(viewModel.formattedDate, "20 Mar, 2002")
    }
}
