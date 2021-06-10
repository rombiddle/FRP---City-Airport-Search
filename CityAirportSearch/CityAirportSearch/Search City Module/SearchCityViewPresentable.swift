//
//  SearchCityViewPresentable.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 08/06/2021.
//

import Foundation

protocol SearchCityViewPresentable {
    associatedtype Input
    associatedtype Output
    
    var input: Input! { get }
    var output: Output! { get }
}
