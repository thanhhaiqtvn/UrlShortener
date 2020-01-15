//
//  UrlShortenerViewTests.swift
//  UrlShortenerTests
//
//  Created by Hai Doan on 1/15/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import XCTest
@testable import UrlShortener

class UrlShortenerViewTests: XCTestCase {

    let mockContainer = MockPersistentContainer().container
    
    var mockUrlShortenerPresenter: MockUrlShortenerPresenter?
    var view: UrlShortenerVC?

    var mockCoreDataManager: MockCoreDataManager?

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

    override func setUp() {
        mockUrlShortenerPresenter = MockUrlShortenerPresenter()

        view = UrlShortenerVC()
        view?.presenter = mockUrlShortenerPresenter

        mockCoreDataManager = MockCoreDataManager(persistentContainer: mockContainer)
    }

    override func tearDown() {
        mockCoreDataManager?.deleteAllData(URLEntity.entityName())
    }

    func testViewDidLoadRequestUrlList() {
        view?.viewDidLoad()

        XCTAssert(mockUrlShortenerPresenter!.viewDidLoadCalled > 0,
                  "Expect viewDidLoad called once on ViewDidLoad()")
    }
    
}
