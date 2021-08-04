//
//  ProductDetailViewController.swift
//  ProductViewer
//
//  Created by Sudipta Sahoo on 02/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit
import RxSwift

final class ProductDetailViewController: UIViewController, ProductDetailViewInput {
    
    //MARK: Properties
    var presenter: ProductDetailViewOutput?
    private var disposeBag = DisposeBag()
    
    lazy var addToCartBtn: UIButton = {
        var btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.setTitle("add to cart", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(.targetStarkWhiteColor, for: .normal)
        btn.backgroundColor =  .targetBullseyeRedColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var addToListBtn: UIButton = {
        var btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.setTitle("add to list", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.backgroundColor = .lightGray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        //An extension can be created to prevent the following line to be written again n again
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descriptionLbl: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textColor = .darkGray
        lbl.numberOfLines = 6
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var currencyLbl: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 56)
        lbl.textColor = .darkGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var priceLbl: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 44)
        lbl.textColor = .darkGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    //MARK: Initialization
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        themeViews()
        setupConstraints()
        assignValues()
    }
    
    //MARK: Private Methods
    
    //Configure Views and subviews
    private func setupViews() {
        view.addSubview(addToCartBtn)
        view.addSubview(addToListBtn)
        view.addSubview(imageView)
        view.addSubview(descriptionLbl)
        view.addSubview(priceLbl)
        view.addSubview(currencyLbl)
        
        addToCartBtn.addTarget(self, action: #selector(didTapAddToCartButton), for: .touchUpInside)
        addToListBtn.addTarget(self, action: #selector(didTapAddToListButton), for: .touchUpInside)
    }
    
    //Assigns value from the source of truth
    //NOTE: This can be made async in case we implement API call to grab these values from server
    private func assignValues() {
        
        presenter?.fetchProductDetail()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] product in
                guard let self = self else {return}
                self.imageView.kf.setImage(with: self.presenter?.product.imageLink)
                self.priceLbl.text = self.presenter?.product.salePrice?.amountString ?? self.presenter?.product.regularPrice.amountString
                self.descriptionLbl.text = self.presenter?.product.description
                self.currencyLbl.text = self.presenter?.product.salePrice?.currencySymbol ?? self.presenter?.product.regularPrice.currencySymbol
                self.title = self.presenter?.product.title
            })
            .disposed(by: disposeBag)
    }
    
    //Apply Theming for views here
    private func themeViews() {
        view.backgroundColor = .white
    }
    
    
    //Apply AutoLayout Constraints
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            addToListBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            addToListBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            addToListBtn.heightAnchor.constraint(equalToConstant: 52),
            
            addToCartBtn.leftAnchor.constraint(equalTo: addToListBtn.leftAnchor),
            addToCartBtn.rightAnchor.constraint(equalTo: addToListBtn.rightAnchor),
            addToCartBtn.bottomAnchor.constraint(equalTo: addToListBtn.topAnchor, constant: -16),
            addToCartBtn.heightAnchor.constraint(equalToConstant: 52),
            
            descriptionLbl.bottomAnchor.constraint(equalTo: addToCartBtn.topAnchor, constant: -16),
            descriptionLbl.leftAnchor.constraint(equalTo: addToListBtn.leftAnchor),
            descriptionLbl.rightAnchor.constraint(equalTo: addToListBtn.rightAnchor),
            
            currencyLbl.bottomAnchor.constraint(equalTo: descriptionLbl.topAnchor, constant: -2),
            currencyLbl.leftAnchor.constraint(equalTo: addToListBtn.leftAnchor),
            
            priceLbl.leftAnchor.constraint(equalTo: currencyLbl.rightAnchor, constant: 2),
            priceLbl.centerYAnchor.constraint(equalTo: currencyLbl.centerYAnchor),
            priceLbl.rightAnchor.constraint(equalTo: addToListBtn.rightAnchor),
            
            imageView.bottomAnchor.constraint(equalTo: priceLbl.topAnchor, constant: -16),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
        ])
        
        //Letting Image to expand vertically if needed.
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        descriptionLbl.setContentHuggingPriority(.defaultHigh, for: .vertical)
        priceLbl.setContentHuggingPriority(.defaultHigh, for: .vertical)

        //Prevent Currency lbl to get expanded. Rather Price lbl can expand horizontally
        currencyLbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                
                addToListBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            ])
        } else {
            NSLayoutConstraint.activate([
                
                addToListBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            ])
        }
    }
    
    
    //MARK:- UIButton Selectors
    
    @objc private func didTapAddToCartButton() {
        
        //presenter?.addToCartAction()
        let myAlert: UIAlertController = UIAlertController(title: title, message: "Added to Cart", preferredStyle: .alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @objc private func didTapAddToListButton() {
        
        //presenter?.addToListAction()
        let myAlert: UIAlertController = UIAlertController(title: title, message: "Added to List", preferredStyle: .alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(myAlert, animated: true, completion: nil)
    }
    
    //MARK: ProductDetailViewInput
}
