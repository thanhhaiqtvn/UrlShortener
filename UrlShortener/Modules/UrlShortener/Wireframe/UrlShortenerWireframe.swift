//
//  UrlShortenerWireframe.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import UIKit

class UrlShortenerWireframe: Wireframe {
    deinit {
        debugPrint(String(describing: self), "deinit")
    }
    
    var viewController: UIViewController {
        let view = UrlShortenerVC()
        let interactor = UrlShortenerInteractor(coreDatamanager: coreDataManager)
        let presenter = UrlShortenerPresenter(interactor: interactor, wireframe: self)

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        return view
    }

}
