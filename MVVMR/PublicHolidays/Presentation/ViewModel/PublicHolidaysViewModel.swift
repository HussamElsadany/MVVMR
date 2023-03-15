//
//  PublicHolidaysViewModel.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 06/06/2022.
//

import Foundation
import StateUIModel
import CoreError
import Bindable

protocol PublicHolidaysViewModelProtocol {
    
    var state: Bindable<StateUIModel> {get}
    var holidays: [BaseUIModel<PublicHoliday>] { get }
    
    func fetchPublicHolidays()
}

final class PublicHolidaysViewModel {
    
    let router: PublicHolidaysRouterProtocol
    let interactor: PublicHolidaysInteractorInProtocol
    private(set) var holidays: [BaseUIModel<PublicHoliday>] = []
    let state: Bindable<StateUIModel>  = Bindable(.loading)


    init(router: PublicHolidaysRouterProtocol, interactor: PublicHolidaysInteractorInProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    private func  onLoading() {
        let state: StateUIModel = .loading
        self.holidays = Array(repeating: .skeleton, count: 10)
        self.state.next(state)
        
    }
    
    private func onSuccess() {
        let state: StateUIModel = .successed
        self.state.next(state)
    }
    
    private func onError(_ error: CoreError) {
        let state: StateUIModel = .failed(error)
        self.state.next(state)
    }
}


// MARK: - PublicHolidaysViewModelProtocol
extension PublicHolidaysViewModel: PublicHolidaysViewModelProtocol {
    func fetchPublicHolidays() {
       
        let year = Calendar.current.component(.year, from: Date())
        let country = "EG"
        
        onLoading()
        interactor.fetchPublicHolidays(country: country, year: year)
    }
}

// MARK: - PublicHolidaysInteractorOutProtocol
extension PublicHolidaysViewModel: PublicHolidaysInteractorOutProtocol {
    func didFailToLoadHolidays(_ error: CoreError) {
        onError(error)
    }
    
    func didLoadPublicHolidays(_ holidays: [PublicHoliday]) {
        self.holidays = holidays.map { .data($0) }
        onSuccess()
    }
}

