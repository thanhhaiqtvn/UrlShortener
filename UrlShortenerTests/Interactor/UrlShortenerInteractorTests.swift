//
//  UrlShortenerInteractorTests.swift
//  UrlShortenerTests
//
//  Created by Hai Doan on 1/16/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import XCTest
@testable import UrlShortener

class UrlShortenerInteractorTests: XCTestCase {

    var mockCoreDataManager: MockCoreDataManager?
    var mockOutput: MockUrlShortenerInteractorOutput?
    var interactor: UrlShortenerInteractor?

    override func setUp() {
        let coreDataManager = MockCoreDataManager(persistentContainer: MockPersistentContainer().container)

        mockOutput = MockUrlShortenerInteractorOutput()
        mockCoreDataManager = coreDataManager

        interactor = UrlShortenerInteractor(coreDatamanager: coreDataManager)
        interactor?.output = mockOutput
    }

    override func tearDown() {
        mockCoreDataManager?.deleteAllData(URLEntity.entityName())
    }

    func testGetUrlListSuccess() {
        // Insert dummy data to core data
        let data1: [String: Any] = [
            UrlKey.idObject.rawValue: "123-AKC-FSC-3FH-D2F",
            UrlKey.dateCreated.rawValue: "14.01.2020",
            UrlKey.url.rawValue: "https://docs.swift.org/swift-book/ReferenceManual/AboutTheLanguageReference.html",
            UrlKey.urlShorten.rawValue: "https://tinyurl.com/y6hoy9ss"
        ]
        let data2: [String: Any] = [
            UrlKey.idObject.rawValue: "123-AKC-FSC-3FH-123",
            UrlKey.dateCreated.rawValue: "14.01.2020",
            UrlKey.url.rawValue: "https://docs.swift.org/swift-book/ReferenceManual/AboutTheLanguageReference.html",
            UrlKey.urlShorten.rawValue: "https://tinyurl.com/y6hoy9ss"
        ]

        guard let url1 = mockCoreDataManager?.create(ofType: URLEntity.self, withData: data1) else {
            XCTFail("Failed creating Url model")

            return
        }

        guard let url2 = mockCoreDataManager?.create(ofType: URLEntity.self, withData: data2) else {
            XCTFail("Failed creating Url model")

            return
        }

        interactor?.retrieveUrlShortenerList()
        
//        XCTAssert(mockOutput!.shortenURLSuccessCalled > 0,
//                  "Expect shortenURLSuccess called once")
        XCTAssert(mockOutput?.urlList?.contains(url1) ?? false,
                  "Ouput doesn't contain expected value url1")
        XCTAssert(mockOutput?.urlList?.contains(url2) ?? false,
                  "Ouput doesn't contain expected value url2")
    }
    
    
    func testAddUrlFailedNilCreatedEntity() {
//        let data: [String: Any] = [
//            UrlKey.idObject.rawValue: "123-AKC-FSC-3FH-D2F",
//            UrlKey.dateCreated.rawValue: "14.01.2020",
//            UrlKey.url.rawValue: "http://URL not correct .html",
//            UrlKey.urlShorten.rawValue: ""
//        ]

        mockCoreDataManager?.stubNil = true

        interactor?.shortenURL(withUrl: "http://URL not correct .html")

        XCTAssert(mockOutput?.shortenURLSuccessCalled == 0, "Expect shortenURLSuccess is not called")
//        XCTAssert(mockOutput?.shortenURLFailedCalled == 1, "Expect shortenURLFailed called once")
//        XCTAssert(mockOutput?.message == "Insert URL to DB failed!",
//                  "Expect shortenURLFailedCalled with message 'Add url failed.'")
    }
}
