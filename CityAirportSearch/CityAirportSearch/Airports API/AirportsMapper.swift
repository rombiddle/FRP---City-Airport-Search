//
//  AirportsMapper.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 08/06/2021.
//

import Foundation

final class AirportsMapper {
    private static var OK_200: Int { return 200 }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteAirports] {
        guard response.statusCode == OK_200,
            let airports = try? JSONDecoder().decode([RemoteAirports].self, from: data) else {
            throw RemoteAirportsLoader.Error.invalidData
        }
        
        return airports
    }
}
