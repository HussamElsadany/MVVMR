//
//  LocalDataSource.swift
//  VIPER
//
//  Created by Hussam Elsadany on 19/06/2022.
//

import Foundation
import CoreNetworking
import CoreError


public class LocalDataSource: LocalDataSourceProtocol {    
    
    private(set) var cache: [String: Any] = [:]
    
    
    public init() {}
    
    public func getData<T: Codable>(endpoint: EndpointProtocol, completion:  @escaping (Result<T, CoreError>)->Void) {
        guard let data = cache[endpoint.cachingKey] as? T
        else {
            completion(.failure(.response(code: "\(URLError.resourceUnavailable)")))
            return
        }
        
        completion(.success(data))
    }
    
    public func saveData<T: Codable>(endpoint: EndpointProtocol ,data: T,completion:  @escaping (Result<T, CoreError>)->Void) {
        cache[endpoint.cachingKey] = data
        completion(.success(data))
    }

}
