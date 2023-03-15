//
//  File.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 17/07/2022.
//

import Foundation
import BaseRepo
import CoreError

public protocol PublicHolidaysRepoProtocol: CacheRepo {
    func fetchPublicHolidays(country: String, year: Int, completion: @escaping (Result<[PublicHoliday], CoreError>)->Void)
}
