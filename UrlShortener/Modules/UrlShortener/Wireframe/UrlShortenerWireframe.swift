//
//  UrlShortenerWireframe.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import UIKit

class UrlShortenerWireframe {
    
    var interactor:UrlShortenerInteractor!
    var presenter:UrlShortenerPresenter!
    
    func getModule() -> UIViewController {
        let view = UrlShortenerVC(nibName: "UrlShortenerVC", bundle: nil)
        
        let entity = UrlEntity()
        let presenter = UrlShortenerPresenter()
        let interactor = UrlShortenerInteractor(entity: entity)
        
        view.urlShortenerPresenter = presenter
        presenter.urlShortenerView = view
        interactor.urlShortenerPresenter = presenter
        presenter.urlShortenerInteractor = interactor
        presenter.urlShortenerWireframe = self
        
        self.interactor = interactor
        self.presenter = presenter
        
        return view
    }
}
