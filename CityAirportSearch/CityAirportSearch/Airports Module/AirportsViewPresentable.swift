//
//  AirportsViewPresentable.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 16/06/2021.
//

import Foundation

protocol AirportsViewPresentable {
    associatedtype Input
    associatedtype Output
    
    var input: Input! { get }
    var output: Output! { get }
}
