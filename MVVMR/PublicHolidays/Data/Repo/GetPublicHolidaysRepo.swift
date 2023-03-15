//
//  GetPublicHolidays.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 05/06/2022.
//

import Foundation
import CoreError
import BaseRepo
import CoreNetworking


final class GetPublicHolidaysRepo: CacheRepo, PublicHolidaysRepoProtocol {
    func fetchPublicHolidays(country: String, year: Int, completion: @escaping (Result<[PublicHoliday], CoreError>)->Void) {
        
        let endpoint: EndpointProtocol = HolidaysEndpoint.getHolidays(country: country, year: year)
       
        getData(endpoint: endpoint, completion: completion)
    }
}
