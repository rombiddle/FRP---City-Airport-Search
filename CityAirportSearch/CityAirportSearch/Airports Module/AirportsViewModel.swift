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
        let airports: [Airport]
    }
    
    struct Output {
        let airportResult: Driver<[SectionModel<String, Airport>]>
    }
    
    private(set) var input: Input!
    private(set) var output: Output!
    private let airports = PublishSubject<[Airport]>()
    
    init(airports: [Airport]) {
        input = Input(airports: airports)
        output = Output(airportResult: airportResult())
    }
    
    private func airportResult() -> Driver<[SectionModel<String, Airport>]> {
        Driver
            .just([SectionModel(model: "", items: input.airports)])
    }
}
