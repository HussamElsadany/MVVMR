//
//  PublicHolidaysRouter.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 06/06/2022.
//

import Foundation
import UIKit
import BaseRepo

public protocol PublicHolidaysRouterProtocol {
    func go(to: PublicHolidaysRoute)
}

public class PublicHolidaysRouter: PublicHolidaysRouterProtocol {
    
    weak var viewController: UIViewController?

    static func assemple() -> UIViewController? {
        //configuration
        //creattion
        let remoteDataSource = RemoteDataSource()
        let localDataSource = LocalDataSource()
        let repo = GetPublicHolidaysRepo(cachePolicy: .always, local: localDataSource, remote: remoteDataSource)
        let interactor = PublicHolidaysInteractor(repo: repo)
        let viewController = PublicHolidaysViewController()
        let router = PublicHolidaysRouter()
        router.viewController = viewController
        let viewModel = PublicHolidaysViewModel(router: router, interactor: interactor)
        interactor.viewModel = viewModel
        viewController.viewModel = viewModel
        router.viewController = viewController

        return  viewController
    }

    public func go(to: PublicHolidaysRoute) {
        //view.push()
    }
}
