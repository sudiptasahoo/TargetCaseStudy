//
//  ListViewController.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo


//NOTES from Sudipta Sahoo
//Page loading is not handled yet

class ListViewController: UIViewController {
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> ListViewController {
        let viewController = ListViewController()
        viewController.coordinator = coordinator
        
        return viewController
    }
    
    lazy var loader: UIActivityIndicatorView = {
        var loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.style = .gray
        return loader
    }()
    
    fileprivate var coordinator: TempoCoordinator!
    
    lazy var collectionView: UICollectionView = {
        let harmonyLayout = HarmonyLayout()
        
        harmonyLayout.collectionViewMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .narrow, left: .none)
        harmonyLayout.defaultSectionMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .none, left: .none)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: harmonyLayout)
        collectionView.backgroundColor = .targetFadeAwayGrayColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addAndPinSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        title = "checkout"
        
        let components: [ComponentType] = [
            ProductListComponent()
        ]
        
        let componentProvider = ComponentProvider(components: components, dispatcher: coordinator.dispatcher)
        let collectionViewAdapter = CollectionViewAdapter(collectionView: collectionView, componentProvider: componentProvider)
        
        coordinator.presenters = [
            SectionPresenter(adapter: collectionViewAdapter),
        ]
        
        registerListeners()
        setupViews()
        setupConstrainsts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        //coordinator.viewState
    }
    
    
    private func setupViews() {
        view.addSubview(loader)
        
        //To be fixed //Pending
        //loader.startAnimating()
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func results() {
        //API value
    }
    
    fileprivate func registerListeners() {
        coordinator.dispatcher.addObserver(ListItemPressed.self) { [weak self] item in
            self?.navigationController?.pushViewController(ProductDetailModuleBuilder.buildModule(with: item.product), animated: true)
        }
    }
}

