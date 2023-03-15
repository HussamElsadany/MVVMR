//
//  HTTPMethod.swift
//
//  Created by Hussam Elsadany on 19/06/2022.
//

import Foundation

public enum HttpMethod: String {
    case get
    case head
    case post
    case put
    case delete
    case connect
    case options
    case trace
    case patch
    
    public var value: String {
        return rawValue.uppercased()
    }
}
