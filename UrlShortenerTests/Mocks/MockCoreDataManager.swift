//
//  MockCoreDataManager.swift
//  UrlShortenerTests
//
//  Created by Hai Doan on 1/15/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

@testable import UrlShortener

class MockCoreDataManager: CoreDataManager {
    private(set) var data: [String: Any]?
    private(set) var saveContextCalled = 0
    private(set) var createCalled = 0
    private(set) var updateCalled = 0

    var stubNil = false

    override func saveContext() {
        self.saveContextCalled += 1

        super.saveContext()
    }

    override func create<T>(ofType: T.Type,
                            withData data: [String : Any]?) -> T? where T : Entity {
        self.data = data
        self.createCalled += 1

        if stubNil {
            return nil
        }

        return super.create(ofType: ofType, withData: data)
    }

    override func update<T>(entity: T, withData data: [String : Any]) where T : Entity {
        self.data = data
        self.updateCalled += 1

        super.update(entity: entity, withData: data)
    }
}
