//
//  RepositoryProtocol.swift
//  VIPER
//
//  Created by Hussam Elsadany on 12/06/2022.
//

import Foundation
import CoreNetworking
import CoreError

public protocol RepoProtocol {
    func getData<T: Codable>(endpoint: EndpointProtocol, completion:  @escaping (Result<T, CoreError>)->Void)
}
