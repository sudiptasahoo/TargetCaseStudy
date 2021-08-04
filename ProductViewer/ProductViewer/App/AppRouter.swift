//
//  AppRouter.swift
//  ProductViewer
//
//  Created by Sudipta Sahoo on 04/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import UIKit

final public class AppRouter {
    
    @discardableResult
    func configureRootViewController(inWindow window: UIWindow?) -> Bool {
        let listCoordinator = ListCoordinator(productListAPIService: ProductListAPIService(network: TargetNetworkService()))
        let navigationController = UINavigationController(rootViewController: listCoordinator.viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
