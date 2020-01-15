//
//  UrlShortenerPresenterTests.swift
//  UrlShortenerTests
//
//  Created by Hai Doan on 1/15/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import XCTest
@testable import UrlShortener

class UrlShortenerPresenterTests: XCTestCase {

    var mockRouter: MockUrlShortenerWireframe?
    var mockView: MockUrlShortenerView?
    var mockInteractor: MockUrlShortenerInteractorInput?
    var presenter: UrlShortenerPresenter?

    let mockContainer = MockPersistentContainer().container
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

    var mockCoreDataManager: MockCoreDataManager?

    override func setUp() {
        let router = MockUrlShortenerWireframe()
        let interactor = MockUrlShortenerInteractorInput()

        mockView = MockUrlShortenerView()
        mockRouter = router
        mockInteractor = interactor

        presenter = UrlShortenerPresenter(interactor: interactor, wireframe: router)
        presenter?.view = mockView

        mockCoreDataManager = MockCoreDataManager(persistentContainer: mockContainer)
    }

    override func tearDown() {
        mockCoreDataManager?.deleteAllData(URLEntity.entityName())
    }

    func testOutputGetUrlListSucess() {

        guard let url1 = URLEntity.create(withData: data1, context: mockContainer.viewContext) as? URLEntity,
            let url2 = URLEntity.create(withData: data2, context: mockContainer.viewContext) as? URLEntity else {
                XCTFail("Failed when creating URL model.")

                return
        }

        presenter?.didRetrieveUrlShortenerList(urlShortenerList: [url1, url2])

        XCTAssert(mockView?.showUrlListCalled == 1, "Expect showUrlList called once")
        XCTAssert(mockView?.urlList == [url1, url2], "Expected urlList sent is not the same!")
    }

    func testUrlShortenerPresenterRequestUrlList() {
        presenter?.viewDidLoad()

        XCTAssert(mockInteractor?.retrieveUrlShortenerListCalled == 1,
                  "Expect calling retrieveUrlShortenerList once.")
    }

    func testUrlShortenerPresenterOnButtonShortenURL() {
        presenter?.onButtonShortenURL(withUrl: "https://docs.swift.org/swift-book/ReferenceManual/AboutTheLanguageReference.html")

        XCTAssert(mockInteractor?.shortenURLCalled == 1,
                  "Expect shortenURLCalled called once.")
    }
}
