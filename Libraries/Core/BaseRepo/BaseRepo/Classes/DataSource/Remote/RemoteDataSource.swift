//
//  RemoteDataSource.swift
//  VIPER
//
//  Created by Hussam Elsadany on 19/06/2022.
//

import Foundation
import CoreNetworking
import CoreError

public class RemoteDataSource: RemoteDataSourceProtocol {    
    
    private let remoteService = RestService()
    
    public init() {}

    public func getData<T>(endpoint: EndpointProtocol, completion: @escaping (Result<T, CoreError>)->Void)   where T : Decodable, T : Encodable {
        remoteService.request(endpoint: endpoint, completion: completion)
    }
}
