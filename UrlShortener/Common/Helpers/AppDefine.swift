//
//  AppDefine.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/16/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

struct AppDefine {
    
}

//MARK: - AppDefine
extension AppDefine {
    static let APP_NAME         = "UrlShortener"
    static let CONTAINER_NAME   = "URL_SHORTENER"
    static let ENTITY_NAME      = "URLEntity"
}

//MARK: - Message Error - UrlShortener
extension AppDefine {
    static let URL_ERR_1                = "validate error!!!"
    static let URL_ERR_2                = "Error: doesn't seem to be a valid URL"
    static let URL_ERR_3                = "doesn't seem to be a valid URL or is blank"
    
    static let INT_URL_ERROR            = "Insert URL to DB failed!"
    static let INT_URL_SUCCESS          = "Insert URL to DB successful."
    
    static let DEL_URL_ERROR            = "Delete Error!"
    static let DEL_URL_SUCCESS          = "Delete successful."
}
