//
//  CoreDataManager.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/16/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer

        super.init()
    }

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint("Error when saving \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteSingleObj(_ entityName: String, With idObject:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        
        fetchRequest.predicate = NSPredicate(format: "(idObject = %@)", argumentArray: [idObject])

        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            
            print("deleteSingleObj Count:::",results.count)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}

                debugPrint("Deleting: \(objectData)")

                persistentContainer.viewContext.delete(objectData)
            }
            
            do {
                try persistentContainer.viewContext.save()
            } catch {
            }
        } catch let error {
            debugPrint("Deleting data \(entityName) error: \(error.localizedDescription)")
        }
    }
    

    func deleteAllData(_ entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            
            print("deleteSingleObj Count:::",results.count)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}

                debugPrint("Deleting: \(objectData)")

                persistentContainer.viewContext.delete(objectData)
            }
        } catch let error {
            debugPrint("Deleting data \(entityName) error: \(error.localizedDescription)")
        }
    }

    // MARK: - Entity Creation
    func create<T: Entity>(ofType: T.Type, withData data: [String: Any]?) -> T? {
        let newEntity = T.create(withData: data, context: persistentContainer.viewContext)
        
        return newEntity as? T
    }

    // MARK: - Entity Update
    func update<T: Entity>(entity: T, withData data: [String: Any]) {
        entity.update(withData: data)
    }

    // MARK: - Fetch Entity
    func fetch<T: Entity>(ofType: T.Type,
                          withPredicate predicate: NSPredicate? = nil,
                          sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName())
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        var entities = [T]()
        do {
            let fetchResult = try persistentContainer.viewContext.fetch(request)

            for data in fetchResult {
                if let entity = data as? T {
                    entities.append(entity)
                }
            }
        } catch {
            debugPrint("Error when fetching")
        }

        return entities
    }
}
