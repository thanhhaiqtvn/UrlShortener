//
//  MockUrlShortenerPresenter.swift
//  UrlShortenerTests
//
//  Created by Hai Doan on 1/15/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

@testable import UrlShortener

class MockUrlShortenerPresenter: UrlShortenerPresenterProtocol {
    
    
    var view: UrlShortenerViewProtocol?
    var interactor: UrlShortenerInteractorInputProtocol?
    var wireframe: UrlShortenerWireframe?
//    var wireframe: UrlShortenerWireframeProtocol?
    
    private(set) var viewDidLoadCalled = 0
    private(set) var onButtonShortenURLCalled = 0
    private(set) var onButtonDeleteURLCalled = 0
    
    func viewDidLoad() {
        self.viewDidLoadCalled += 1
    }
    
    func onButtonShortenURL(withUrl url: String) {
        self.onButtonShortenURLCalled += 1
    }
    
    func onButtonDeleteURL(withId id: String) {
        self.onButtonDeleteURLCalled += 1
    }

}
