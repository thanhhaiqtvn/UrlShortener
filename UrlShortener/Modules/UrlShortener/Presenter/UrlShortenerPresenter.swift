//
//  UrlShortenerPresenter.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

class UrlShortenerPresenter: UrlShortenerPresenterProtocol, UrlShortenerInteractorOutput {
    
    weak var urlShortenerView:UrlShortenerView?
    weak var urlShortenerInteractor:UrlShortenerInteractorInput?
    var urlShortenerWireframe:UrlShortenerWireframe? //
    
    // UrlShortenerPresenter
    func didUrlShortener(url:String) {
        urlShortenerInteractor?.shortenURL(url: url)
    }
            
    //MARK:- Adopt UrlShortenerPresenterProtocol
    func getListUrl() {
        self.urlShortenerInteractor?.getDataStore()
    }
    
    //MARK:- Adopt UrlShortenerInteractorOutput
    func validateError(error:String) {
        self.urlShortenerView?.validateError(error: error)
    }
    
    func urlShortenerFail(error:String) {
        self.urlShortenerView?.urlShortenerFail(error: error)
    }

    func urlShortenerSuccess(with urlShorted: String) {
        self.urlShortenerView?.urlShortenerSuccess(with: urlShorted)
    }
    
}
