//
//  NetworkService.swift
//  ProductViewer
//
//  Created by Sudipta Sahoo on 02/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

enum TargetError: Error {
    
    //A lot of improvement is possible here
    
    case networkError(_ error: Error)
    case malformedResponse
    case noResponse
}

protocol NetworkService {
    func fetch<T: Decodable>(from urlRequest: URLRequest, completion: @escaping (Swift.Result<T, TargetError>) -> Void)
}

extension NetworkService {
    
    func fetch<T: Decodable>(from urlRequest: URLRequest, completion: @escaping (Swift.Result<T, TargetError>) -> Void) {
        
        //A lot of improvement is possible here
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.malformedResponse))
            }
        }
        task.resume()
    }
}
 
struct TargetNetworkService: NetworkService {}
