//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    fileprivate var productListAPIService: ProductListAPIService
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    let dispatcher = Dispatcher()
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init(productListAPIService: ProductListAPIService) {
        self.productListAPIService = productListAPIService
        viewState = ListViewState(listItems: [])
        
        fetchProducts()
    }
    
    // MARK: ListCoordinator
    
    fileprivate func fetchProducts() {
        productListAPIService.fetchProducts {[weak self] result in
            switch result {
            case .success(let products):
                self?.updateList(with: products)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func updateList(with products: [Product]) {
        
        var tViewState = ListViewState(listItems: [])
        tViewState.listItems = products.map { product in
            ListItemViewState(product: product)
        }
        self.viewState = tViewState
    }
}
