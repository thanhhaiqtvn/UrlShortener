//
//  Wireframe.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/16/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import UIKit

protocol Wireframe {
    var viewController: UIViewController { get }
}

extension Wireframe {
    var coreDataManager: CoreDataManager {
        guard let coreDataManager = (UIApplication.shared.delegate as? AppDelegate)?
            .coreDataManager else {
                fatalError("Cannot get coredata manager.")
        }

        return coreDataManager
    }
}
