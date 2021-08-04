//
//  ProductDetailModuleBuilder.swift
//  ProductViewer
//
//  Created by Sudipta Sahoo on 02/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import UIKit

struct ProductDetailModuleBuilder: ProductDetailBuilder {
    
    //MARK: ProductDetailBuilder method
    static func buildModule(with product: Product) -> ProductDetailViewController {
        let viewController = ProductDetailViewController()
        let router = ProductDetailRouter(viewController: viewController)
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter(product: product)
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        return viewController
    }
}
