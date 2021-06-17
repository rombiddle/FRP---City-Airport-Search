//
//  SearchCityViewController.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 04/06/2021.
//

import UIKit
import RxSwift
import RxDataSources

typealias CitySearchModel = SectionModel<Int, Airport>

class SearchCityViewController: UIViewController {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchCityViewModel!
    private let disposeBag = DisposeBag()
    var loader: AirportsLoader?
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData> { (_, tableView, indexPath, item) -> UITableViewCell in
        if let cityCell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell {
            cityCell.configure(with: CityTableViewModel(city: item.city, location: item.country))
            return cityCell
        }
        return UITableViewCell()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelInputs()
        bindViewModelOuputs()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
    }
    
    private func bindViewModelInputs() {
        searchTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.input.searchText)
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Airport.self)
            .bind(to: viewModel.input.citySelect)
            .disposed(by: disposeBag)
    }
    
    private func bindViewModelOuputs() {
        viewModel
            .output
            .airportResult
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

