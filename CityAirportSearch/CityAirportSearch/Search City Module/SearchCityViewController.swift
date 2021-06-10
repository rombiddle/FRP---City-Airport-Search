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
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData> { (_, tableView, indexPath, item) -> UITableViewCell in
        let cell = UITableViewCell()
        cell.textLabel?.text = item.city
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = URLSessionHTTPClient()
        let url = URL(string: "https://raw.githubusercontent.com/rombiddle/FRP---City-Airport-Search/master/aiports.json")!
        let loader = RemoteAirportsLoader(url: url, client: client)
        viewModel = SearchCityViewModel(client: loader)
        bindViewModelInputs()
        bindViewModelOuputs()
    }
    
    private func bindViewModelInputs() {
        searchTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.input.searchText)
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
