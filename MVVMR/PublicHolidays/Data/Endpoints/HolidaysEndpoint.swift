//
//  HolidaysEndpoint.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 17/07/2022.
//

import Foundation
import CoreNetworking

enum HolidaysEndpoint: EndpointProtocol {
    case getHolidays(country: String, year: Int)
}


extension HolidaysEndpoint {
    var baseURL: String { "https://date.nager.at" }
    
    var path: String {
        guard case let .getHolidays(country, year) = self else { return "/api/v2/publicholidays" }
        return "/api/v2/publicholidays/\(year)/\(country)"
    }
}
