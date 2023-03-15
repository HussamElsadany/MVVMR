//
//  Collection.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 19/07/2022.
//

import Foundation
import CoreError

public extension Collection where Indices.Iterator.Element == Index {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
