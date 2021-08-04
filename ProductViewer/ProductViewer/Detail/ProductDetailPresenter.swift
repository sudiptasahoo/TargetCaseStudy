//
//  ProductDetailPresenter.swift
//  ProductViewer
//
//  Created by Sudipta Sahoo on 02/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import RxSwift

final class ProductDetailPresenter: ProductDetailViewOutput, ProductDetailModuleInput {
    
    //MARK: Properties
    weak var view: ProductDetailViewInput?
    var router: ProductDetailRouterInput!
    var interactor: ProductDetailInteractorInput!
    var product: Product
    
    //MARK: Initialization
    init(product: Product) {
        self.product = product
    }
    
    //MARK: ProductDetailViewOutput methods
    func addToCartAction() {
        //To be used
    }
    
    func addToListAction() {
        //To be used
    }
    
    func fetchProductDetail() -> Observable<Product> {
        return Observable.just(product)
    }
}

