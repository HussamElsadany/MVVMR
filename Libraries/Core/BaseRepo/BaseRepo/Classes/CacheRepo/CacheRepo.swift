//
//  DefaultCacheRepository.swift
//  VIPER
//
//  Created by Hussam Elsadany on 19/06/2022.
//

import Foundation
import CoreError
import CoreNetworking


open class CacheRepo: CacheRepoProtocol {
    
    public typealias Local = LocalDataSourceProtocol
    public typealias Remote = RemoteDataSourceProtocol
    
    public var cachePolicy: CachePolicy
    
    private let local: Local
    private let remote: Remote
    
    public init(cachePolicy: CachePolicy, local: Local, remote: Remote) {
        self.cachePolicy = cachePolicy
        self.local = local
        self.remote = remote
    }
        
    final public func getData<T: Codable>(endpoint: EndpointProtocol ,completion: @escaping (Result<T, CoreError>)->Void){
        switch cachePolicy {
        case .never:
            remote.getData(endpoint: endpoint, completion: completion)
        case .always:
            getCachedFirst(endpoint: endpoint, completion: completion)
        case .remoteFirst:
            fetchRemoteFirst(endpoint: endpoint, completion: completion)
        }
    }
    
    private func getCachedFirst<T: Codable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, CoreError>)->Void) {
        local.getData(endpoint: endpoint) {[weak self] (result: Result<T, CoreError>)  in
            switch result {
            case let .success(data):
                completion(.success(data))
            case .failure:
                self?.fetchData(endpoint: endpoint, completion: completion)
            }
        }
    }
    
    private func fetchData<T: Codable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, CoreError>)->Void) {
        remote.getData(endpoint: endpoint) {[weak self] (result: Result<T, CoreError>)  in
            switch result {
            case let .success(data):
                self?.local.saveData(endpoint: endpoint, data: data, completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchRemoteFirst<T: Codable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, CoreError>)->Void) {
        remote.getData(endpoint: endpoint) {[weak self] (result: Result<T, CoreError>)  in
            switch result {
            case let .success(data):
                self?.local.saveData(endpoint: endpoint, data: data, completion: completion)
            case .failure:
                self?.local.getData(endpoint: endpoint, completion: completion)
            }
        }
    }
}
