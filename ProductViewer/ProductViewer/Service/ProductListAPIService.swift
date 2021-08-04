//
//  ProductListAPIService.swift
//  ProductViewer
//
//  Created by Sudipta Sahoo on 02/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

struct ProductListAPIService {
    
    private var network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func fetchProducts(completion: @escaping (Swift.Result<[Product], TargetError>) -> Void) {
        let url = URL(string: "\(APIConstants.BASE_URL)\(APIConstants.PRODUCT_LIST_API)")! //graceful handling possible here
        let urlRequest = URLRequest(url: url)
        network.fetch(from: urlRequest) { (result: Result<ProductResponse, TargetError>) in
            switch result {
            case .success(let productResponse): completion(.success(productResponse.products))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
