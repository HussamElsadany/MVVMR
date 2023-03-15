//
//  BaseUIModel.swift
//  StateUIModel
//
//  Created by Hussam Elsadany on 19/07/2022.
//

import Foundation

public enum BaseUIModel<T> {
    case data(_ value: T)
    case skeleton
}

public extension BaseUIModel {
    var value: T? {
        guard case let .data(data) = self else {return nil}
        return data
    }
    
    var isSkeleton: Bool {
        guard case .skeleton = self else {return false}
        return true
    }
    
}
