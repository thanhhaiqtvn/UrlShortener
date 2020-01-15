//
//  UrlShortenerProtocols.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/16/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import UIKit

//MARK: PRESENTER -> VIEW
protocol UrlShortenerViewProtocol: class {
    var presenter: UrlShortenerPresenterProtocol? { get set }
    
    func showUrlList(with urls: [URLEntity])
    
    func shortenURLSuccess(urlShorten: URLEntity)
    func showAlert(withMessage message: String, animated: Bool)
}

//MARK: VIEW -> PRESENTER
protocol UrlShortenerPresenterProtocol: class {
    var view: UrlShortenerViewProtocol? { get set }
    var interactor: UrlShortenerInteractorInputProtocol? { get set }
    var wireframe: UrlShortenerWireframe? { get set }
    
    func viewDidLoad()
    
    func onButtonShortenURL(withUrl url: String)
    
    func onButtonDeleteURL(withId id: String)
}

//MARK: PRESENTER -> INTERACTOR
protocol UrlShortenerInteractorInputProtocol: class {
    var output: UrlShortenerInteractorOutputProtocol? { get set }
//    var localDatamanager: UrlShortenerLocalDataManagerInputProtocol? { get set }
    
    func retrieveUrlShortenerList()
    
    func shortenURL(withUrl url: String)
    
    func deleteURL(withId id: String)
}

//MARK: INTERACTOR -> PRESENTER
protocol UrlShortenerInteractorOutputProtocol: class {
    func didRetrieveUrlShortenerList(urlShortenerList: [URLEntity])
    
    func shortenURLSuccess(urlShortener: URLEntity)
    func shortenURLFailed(withMessage message: String)
    
    func didDeleteURL(withMessage message: String)
}
