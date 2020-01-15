//
//  AppDelegate.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private(set) var coreDataManager: CoreDataManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize core data
        coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationWillTerminate(_ application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
            // Saves changes in the application's managed object context before the application terminates.
    //        coreDataManager?.saveContext()
        }
        
        // MARK: - Core Data
        private lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: AppDefine.CONTAINER_NAME)
            container.loadPersistentStores(completionHandler: { (_, error) in
                if let error = error as NSError? {
                    debugPrint("Error when loading core data \(error), \(error.userInfo)")
                }
            })
            return container
        }()

}

