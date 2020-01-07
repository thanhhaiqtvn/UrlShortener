//
//  UrlShortenerPresenterProtocol.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

protocol UrlShortenerPresenterProtocol:class {
    func getListUrl()
    func didUrlShortener(url:String)
}
