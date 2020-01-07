//
//  UrlShortenerInteractorIO.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

protocol UrlShortenerInteractorInput:class {
    func getDataStore()
    func shortenURL(url:String)
}

protocol UrlShortenerInteractorOutput:class {
    func validateError(error:String)
    func urlShortenerFail(error:String)
    func urlShortenerSuccess(with urlShorted:String)
}
