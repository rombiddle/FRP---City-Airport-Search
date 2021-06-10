//
//  HTTPCLient.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 07/06/2021.
//

import Foundation
import RxSwift

protocol AirportsLoader {
    typealias Result = [Airport]
    func fetchAirports() -> Single<Result>
}
