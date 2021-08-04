//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo


//NOTES from Sudipta Sahoo
//I read the Tempo doc and found it useful to remove the dependency on the xib file. It's hard to maintain a xib than writing UI using code only.


final class ProductListView: UIView, ReusableView {
    
    @nonobjc static let reuseID = "ProductListViewIdentifier"
    
    lazy var productImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        //An extension can be created to prevent the following line to be written again n again
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLbl: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .darkGray
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var priceLbl: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textColor = .darkGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var separatorLine: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        themify()
        setupViews()
        setupConstraints()
    }
    
    private func themify() {
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    private func setupViews() {
        addSubview(separatorLine)
        addSubview(productImage)
        addSubview(priceLbl)
        addSubview(titleLbl)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            productImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            productImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            productImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor, multiplier: 1),
            
            separatorLine.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 8),
            separatorLine.rightAnchor.constraint(equalTo: rightAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            separatorLine.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLbl.topAnchor.constraint(equalTo: productImage.topAnchor),
            titleLbl.leftAnchor.constraint(equalTo: separatorLine.leftAnchor),
            titleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            //titleLbl.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -4),
            
            priceLbl.leftAnchor.constraint(equalTo: separatorLine.leftAnchor),
            priceLbl.rightAnchor.constraint(equalTo: titleLbl.rightAnchor),
            priceLbl.bottomAnchor.constraint(equalTo: productImage.bottomAnchor, constant: -8)
        ])
        
        //titleLbl.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}

//
//extension ProductListView: ReusableNib {
//    @nonobjc static let nibName = "ProductListView"
//    @nonobjc static let reuseID = "ProductListViewIdentifier"
//
//    @nonobjc func prepareForReuse() {
//        
//    }
//}
