//
//  MockedEndPoint.swift
//  CoreNetworking-Unit-CoreNetworkingTests
//
//  Created by Hussam Elsadany on 19/07/2022.
//

import Foundation
import CoreNetworking

enum MockedEndPoint: EndpointProtocol {
    case mocks(path: String)
}


extension MockedEndPoint {
    var baseURL: String {"https://date.nager.at"}
    
    var path: String {
        guard case let .mocks(path) = self else { return "" }
        return "/\(path)"
    }
}


