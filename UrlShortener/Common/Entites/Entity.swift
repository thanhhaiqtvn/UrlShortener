//
//  Entity.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/16/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation
import CoreData

protocol EntityKey: Hashable {
}

protocol Entity {
    static func entityName() -> String

    static func create(withData data: [String: Any]?,
                       context: NSManagedObjectContext) -> Entity?
    
    func update(withData data: [String: Any])
}

