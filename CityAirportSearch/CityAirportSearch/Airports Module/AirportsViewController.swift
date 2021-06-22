//
//  AirportsViewController.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 16/06/2021.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift
import RxDataSources

class AirportsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var airports: [Airport]?
    private let disposeBag = DisposeBag()
    var viewModel: AirportsViewModel!
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Airport>> { (_, tableView, indexPath, item) -> UITableViewCell in
        if let airportCell = tableView.dequeueReusableCell(withIdentifier: "AirportTableViewCell", for: indexPath) as? AirportTableViewCell {
            airportCell.configure(with: AirportTableViewModel(airportName: item.name, city: item.city, country: item.country, geolocation: "\(item._geoloc.lng), \(item._geoloc.lat)"))
            return airportCell
        }
        return UITableViewCell()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModelOuputs()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "AirportTableViewCell", bundle: nil), forCellReuseIdentifier: "AirportTableViewCell")
    }
    
    private func bindViewModelOuputs() {
        viewModel
            .output
            .airportResult
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}
