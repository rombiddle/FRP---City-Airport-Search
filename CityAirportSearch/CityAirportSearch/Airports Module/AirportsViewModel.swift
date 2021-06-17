//
//  AirportsViewModel.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 16/06/2021.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct AirportsViewModel: ViewModelPresentable {
    struct Input {
        let airports: AnyObserver<[Airport]>
    }
    
    struct Output {
        let airportResult: Driver<[SectionModel<String, Airport>]>
    }
    
    private(set) var input: Input!
    private(set) var output: Output!
    
    init() {
        input = Input(searchText: searchText.asObserver())
        output = Output(airportResult: airportResult())
    }
    
    private func airportResult() -> Driver<[SectionModel<String, Airport>]> {
        airports
            .asDriver()
            .map({ airports in
                [SectionModel(model: "", items: airports)]
            })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
