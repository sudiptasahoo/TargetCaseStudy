//
//  ProductDetailRouter.swift
//  ProductViewer
//
//  Created by Sudipta Sahoo on 02/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import UIKit

final class ProductDetailRouter: ProductDetailRouterInput {

    //MARK: Properties
    private weak var viewController: ProductDetailViewController?
    
    
    //MARK: Initialiser
    init(viewController: ProductDetailViewController) {
        self.viewController = viewController
    }
    
    //MARK: ProductDetailRouterInput methods
}

