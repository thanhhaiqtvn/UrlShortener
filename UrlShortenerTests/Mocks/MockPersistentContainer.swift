//
//  MockPersistentContainer.swift
//  UrlShortenerTests
//
//  Created by Hai Doan on 1/15/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import CoreData

class MockPersistentContainer {
    static let CONTAINER_NAME   = "URL_SHORTENER"
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: MockPersistentContainer.CONTAINER_NAME)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
}
