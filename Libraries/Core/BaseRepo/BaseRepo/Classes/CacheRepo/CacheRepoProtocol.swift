//
//  CacheRepository.swift
//  Repository
//
//  Created by Hussam Elsadany on 19/06/2022.
//

import Foundation

public protocol CacheRepoProtocol: RepoProtocol {
    
    associatedtype Local
    associatedtype Remote
    
    var cachePolicy: CachePolicy { get }
}
