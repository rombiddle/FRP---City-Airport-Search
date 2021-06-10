//
//  SearchCityViewModel.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 04/06/2021.
//

import Foundation
import RxCocoa
import RxSwift

class SearchCityViewModel: SearchCityViewPresentable {
    struct Input {
        let searchText: AnyObserver<String>
    }
    
    struct Output {
        let airportResult: Driver<[SectionOfCustomData]>
    }
    
    private(set) var input: Input!
    private(set) var output: Output!
    private var client: AirportsLoader
    private let disposeBag = DisposeBag()
    
    private let searchText = PublishSubject<String>()
    private var airports = BehaviorRelay<[Airport]>(value: [])
    
    init(client: AirportsLoader) {
        self.client = client
        input = Input(searchText: searchText.asObserver())
        output = Output(airportResult: airportSearch())
        
        client
            .fetchAirports()
            .subscribe { result in
                switch result {
                case let .success(airports):
                    self.airports.accept(airports)
                case .failure:
                    self.airports.accept([])
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func airportSearch() -> Driver<[SectionOfCustomData]> {
        searchText
            .asObservable()
            .map { city -> [Airport] in
                self.airports.value.filter { airport -> Bool in
                    airport.city.contains(city)
                }
            }
            .map({ airports -> [SectionOfCustomData] in
                [SectionOfCustomData(header: "", items: airports)]
            })
            .asDriver(onErrorJustReturn: [SectionOfCustomData(header: "", items: [])])
    }
}
