//
//  ProductDetailProtocols.swift
//  ProductViewer
//
//  Created by Sudipta Sahoo on 02/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

//MARK: View
protocol ProductDetailViewInput: AnyObject {}

//MARK: Presenter
protocol ProductDetailViewOutput: AnyObject {
    
    ///Add to Cart button action
    func addToCartAction()
    
    ///Add to List button action
    func addToListAction()
    
    ///Fetch Product Details from the source of truth
    func fetchProductDetail() -> Observable<Product>
    
    //Single source of truth
    var product: Product { get }
}

protocol ProductDetailModuleInput: AnyObject {
    //MARK: Presenter Variables
    var view: ProductDetailViewInput? { get set }
    var interactor: ProductDetailInteractorInput! { get set }
    var router: ProductDetailRouterInput! { get set }
}

//MARK: Interactor
protocol ProductDetailInteractorInput: AnyObject {
    //TODO: Declare interactor methods
}

//MARK: Router
protocol ProductDetailRouterInput: AnyObject {
    //TODO: Declare router methods
}

//MARK: ProductDetailModuleBuilder
protocol ProductDetailBuilder {
    static func buildModule(with product: Product) -> ProductDetailViewController
}

