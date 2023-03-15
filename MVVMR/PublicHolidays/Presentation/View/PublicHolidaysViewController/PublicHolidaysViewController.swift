//
//  PublicHolidaysViewController.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 06/06/2022.
//

import UIKit
import Utils
import Bindable

final class PublicHolidaysViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PublicHolidaysViewModelProtocol!
    fileprivate let disposeBag = DisposableBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PublicHoliday_ID")
        
        viewModelDidChange()
        viewModel?.fetchPublicHolidays()
    }
}


// MARK: - UITableViewDataSource
extension PublicHolidaysViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.holidays.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PublicHoliday_ID"),
              let holidays = viewModel?.holidays,
              let holiday = holidays[safe: indexPath.row]
        else {
            return UITableViewCell()
        }
        
        
        if(holiday.isSkeleton) {
            cell.textLabel?.text = "....."
            cell.detailTextLabel?.text = "- - - - -"
        }
        else {
            cell.textLabel?.text = holiday.value?.localName
            cell.detailTextLabel?.text = holiday.value?.date
        }
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension PublicHolidaysViewController: UITableViewDelegate {
    
}


// MARK: - PublicHolidaysViewControllerProtocol
extension PublicHolidaysViewController {
    
    func viewModelDidChange() {
        viewModel.state.bind {[weak self] state in
            self?.reloadData()
            switch state {
            case .loading, .successed: break
            case let .failed(error):
                print(error)
                //trigger(error)
            }
        }
        .add(to: disposeBag)
    }

    func reloadData() {
        tableView.reloadData()
    }
}
