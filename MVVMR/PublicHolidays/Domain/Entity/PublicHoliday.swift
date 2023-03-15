//
//  PublicHoliday.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 05/06/2022.
//

import Foundation

public struct PublicHoliday: Codable {
    let date: String
    let localName: String
    let fixed: Bool
    let global: Bool
    let counties: [String]?
}
