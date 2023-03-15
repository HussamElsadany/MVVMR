//
//  LocalDataSource.swift
//  VIPER
//
//  Created by Hussam Elsadany on 19/06/2022.
//

import Foundation
import CoreError
import CoreNetworking


public protocol LocalDataSourceProtocol: RepoProtocol {
    func saveData<T: Codable>(endpoint: EndpointProtocol ,data: T,completion:  @escaping (Result<T, CoreError>)->Void)
}
