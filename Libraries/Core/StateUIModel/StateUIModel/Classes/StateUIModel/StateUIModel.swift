//
//  StateUIModel.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 19/07/2022.
//

import Foundation
import CoreError


public enum StateUIModel {
    case loading
    case successed
    case failed(_ error: CoreError)
}
