//
//  PublicHolidaysInteractor.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 06/06/2022.
//

import Foundation
import CoreError

public protocol PublicHolidaysInteractorInProtocol {
    func fetchPublicHolidays(country: String, year: Int)
}

public protocol PublicHolidaysInteractorOutProtocol: AnyObject {
    func didLoadPublicHolidays(_ publicHolidays: [PublicHoliday])
    func didFailToLoadHolidays(_ error: CoreError)
}

public class PublicHolidaysInteractor {
    weak var viewModel: PublicHolidaysInteractorOutProtocol?
    let repo: PublicHolidaysRepoProtocol

    public init(repo: PublicHolidaysRepoProtocol) {
        self.repo = repo
    }
}

// MARK: - PublicHolidaysInteractorInProtocol
extension PublicHolidaysInteractor: PublicHolidaysInteractorInProtocol {
    public func fetchPublicHolidays(country: String, year: Int) {
        
        repo.fetchPublicHolidays(country: country, year: year) { result in
            switch result {
            case let .success(data):
                self.viewModel?.didLoadPublicHolidays(data)
            case let .failure(error):
                self.viewModel?.didFailToLoadHolidays(error)
            }
        }
    }
}
