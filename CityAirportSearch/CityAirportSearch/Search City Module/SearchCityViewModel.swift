//
//  SearchCityViewModel.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 04/06/2021.
//

import Foundation
import RxCocoa
import RxSwift

class SearchCityViewModel: ViewModelPresentable {
    struct Input {
        let searchText: AnyObserver<String>
        let citySelect: AnyObserver<Airport>
    }
    
    struct Output {
        let airportResult: Driver<[SectionOfCustomData]>
    }
    
    private(set) var input: Input!
    private(set) var output: Output!
    private var client: AirportsLoader
    private let disposeBag = DisposeBag()
    
    private let searchText = PublishSubject<String>()
    private let citySelect = PublishSubject<Airport>()
    private var airports = BehaviorRelay<[Airport]>(value: [])
    var citySelection: ([Airport]) -> Void
    
    init(client: AirportsLoader, citySelection: @escaping ([Airport]) -> Void) {
        self.client = client
        self.citySelection = citySelection
        input = Input(searchText: searchText.asObserver(), citySelect: citySelect.asObserver())
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
        
        citySelect
            .asObservable()
            .map({ $0.city })
            .withLatestFrom(airports.asObservable()) { ($0, $1) }
            .map { (city, airports) in
                airports.filter({ $0.city == city })
            }
            .map({
                citySelection($0)
                print("Airports selected \($0)")
            })
            .subscribe()
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
