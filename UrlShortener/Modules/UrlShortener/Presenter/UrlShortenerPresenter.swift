//
//  UrlShortenerPresenter.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

class UrlShortenerPresenter: UrlShortenerPresenterProtocol {

    weak var view: UrlShortenerViewProtocol?
    var interactor: UrlShortenerInteractorInputProtocol?
//    var wireframe: UrlShortenerWireframeProtocol? //
    var wireframe: UrlShortenerWireframe? //
    
    init(interactor: UrlShortenerInteractorInputProtocol, wireframe: UrlShortenerWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }

    //MARK:- Adopt UrlShortenerPresenterProtocol
    func viewDidLoad() {
        interactor?.retrieveUrlShortenerList()
    }
    
    func onButtonShortenURL(withUrl url: String) {
        interactor?.shortenURL(withUrl: url)
    }
    
    func onButtonDeleteURL(withId id: String) {
        interactor?.deleteURL(withId: id)
    }
    
}

//MARK:- Adopt UrlShortenerInteractorOutputProtocol
extension UrlShortenerPresenter: UrlShortenerInteractorOutputProtocol {

    func didRetrieveUrlShortenerList(urlShortenerList: [URLEntity]) {
        view?.showUrlList(with: urlShortenerList)
    }
    
    func shortenURLSuccess(urlShortener: URLEntity) {
        view?.shortenURLSuccess(urlShorten: urlShortener)
    }
    
    func shortenURLFailed(withMessage message: String) {
        view?.showAlert(withMessage: message, animated: true)
    }
    
    func didDeleteURL(withMessage message: String) {
        view?.showAlert(withMessage: message, animated: true)
    }

}
