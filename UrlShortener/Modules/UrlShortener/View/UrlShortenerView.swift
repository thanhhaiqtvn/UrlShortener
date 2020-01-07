//
//  UrlShortenerView.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

protocol UrlShortenerView:class {    
    func validateError(error: String)
    func urlShortenerFail(error: String)
    func urlShortenerSuccess(with urlShorted:String)
}
