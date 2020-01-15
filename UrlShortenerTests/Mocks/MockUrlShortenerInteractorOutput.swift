//
//  MockUrlShortenerInteractorOutput.swift
//  UrlShortenerTests
//
//  Created by Hai Doan on 1/15/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation
@testable import UrlShortener

class MockUrlShortenerInteractorOutput: UrlShortenerInteractorOutputProtocol {
    private(set) var urlList: [URLEntity]?
    
    private(set) var didRetrieveUrlShortenerListCalled = 0
    private(set) var shortenURLSuccessCalled = 0
    private(set) var shortenURLFailedCalled = 0
    private(set) var didDeleteURLCalled = 0
    private(set) var message: String?
    
    func didRetrieveUrlShortenerList(urlShortenerList: [URLEntity]) {
        self.urlList = urlShortenerList
        self.didRetrieveUrlShortenerListCalled += 1
    }
    
    func shortenURLSuccess(urlShortener: URLEntity) {
        self.shortenURLSuccessCalled += 1
    }
    
    func shortenURLFailed(withMessage message: String) {
        self.message = message
        self.shortenURLFailedCalled += 1
    }
    
    func didDeleteURL(withMessage message: String) {
        self.didDeleteURLCalled += 1
    }
}
