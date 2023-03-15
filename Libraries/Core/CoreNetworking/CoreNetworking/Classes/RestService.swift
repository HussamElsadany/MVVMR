//
//  RestService.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 11/07/2022.
//

import Foundation
import CoreError


//MARK: - RestServiceProtocol
public typealias HTTPResponseCallback<T> =  (Result<T, CoreError>) -> Void

public protocol RestServiceProtocol {
    func request<T: Codable>(endpoint: EndpointProtocol, deliverQueue: DispatchQueue,completion: @escaping (Result<T, CoreError>) -> Void)
}


public struct  RestService: RestServiceProtocol {
    
    
    private let session: URLSession
    
    
    public init(config: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: config)
    }
    
    public func request<T: Codable>(endpoint: EndpointProtocol, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping HTTPResponseCallback<T>) {
        
        guard let urlRequest = endpoint.urlRequest else {
            deliverQueue.async {
                completion(.failure(.request(code: "\(URLError.badURL)")))
            }
            return
        }
        
        let task =  URLSession.shared.dataTask(with: urlRequest) { result in
            deliverQueue.async {
                let decoder = endpoint.decoder(type: T.self)
                completion(decoder.decode(result))
            }
        }
        
        task.resume()
    }
    
}
