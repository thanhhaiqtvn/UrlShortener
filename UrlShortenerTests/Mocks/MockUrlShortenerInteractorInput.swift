//
//  MockUrlShortenerInteractorInput.swift
//  UrlShortenerTests
//
//  Created by Hai Doan on 1/15/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

@testable import UrlShortener

class MockUrlShortenerInteractorInput: UrlShortenerInteractorInputProtocol {
    var output: UrlShortenerInteractorOutputProtocol?
        
    private(set) var retrieveUrlShortenerListCalled = 0
    private(set) var shortenURLCalled = 0
    private(set) var deleteURLCalled = 0
    
    func retrieveUrlShortenerList() {
        self.retrieveUrlShortenerListCalled += 1
    }
    
    func shortenURL(withUrl url: String) {
        self.shortenURLCalled += 1
    }
    
    func deleteURL(withId id: String) {
        self.deleteURLCalled += 1
    }
}
