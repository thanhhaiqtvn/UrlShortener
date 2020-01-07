//
//  Persistable.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/7/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

protocol Persistable{
    var ud: UserDefaults {get}
    var persistKey : String {get}
    func persist()
    func unpersist()
}
