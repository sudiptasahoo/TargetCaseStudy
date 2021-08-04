//
//  Product.swift
//  ProductViewer
//
//  Created by Sudipta Sahoo on 02/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation


struct ProductResponse: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    
    let id: Int
    let title: String
    let aisle: String
    let description: String
    private let imageUrl: String
    let regularPrice: ProductPrice
    let salePrice: ProductPrice?
    
    var imageLink: URL? {
        get {
            return URL(string: imageUrl)
        }
    }
}

struct ProductPrice: Decodable {
    
    let amountInCents: Int
    let currencySymbol: String
    let displayString: String
    
    //To be discussed with the Backend to understand if below logic will always work
    var amountString: String {
        var tStr = displayString
        tStr.removeFirst()
        return tStr
    }
}
