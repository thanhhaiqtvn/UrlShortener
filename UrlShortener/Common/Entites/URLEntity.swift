//
//  URLEntity.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/16/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation
import CoreData

enum UrlKey: String {
    case idObject
    case dateCreated
    case url
    case urlShorten
}

extension URLEntity: Entity {
    static func entityName() -> String {
        return AppDefine.ENTITY_NAME
    }

    static func create(withData data: [String : Any]?,
                       context: NSManagedObjectContext) -> Entity? {
        guard let url = NSEntityDescription.insertNewObject(forEntityName: URLEntity.entityName(),
                                                             into: context) as? URLEntity else {
            return nil
        }

        if let data = data {
            url.update(withData: data)
        }
        
        do {
            try context.save()
        } catch  {
            
        }

        return url
    }
    
    func update(withData data: [String: Any]) {
        for (_, keyValue) in data.enumerated() {
            guard let key = UrlKey(rawValue: keyValue.key) else {
                continue
            }

            switch key {
            case .idObject:
                guard let value = keyValue.value as? String else { continue }
                self.idObject = value
            case .dateCreated:
                guard let value = keyValue.value as? String else { continue }
                self.dateCreated = value
            case .url:
                guard let value = keyValue.value as? String else { continue }
                self.url = value
            case .urlShorten:
                guard let value = keyValue.value as? String else { continue }
                self.urlShorten = value
            }
        }
    }
    
}

