//
//  RemoteAirports.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 08/06/2021.
//

import Foundation

struct RemoteAirports: Decodable {
    let name: String
    let city: String
    let country: String
    let iata_code: String
    let _geoloc: RemoteGeoloc
    let links_count: Int
    let objectID: String
}
