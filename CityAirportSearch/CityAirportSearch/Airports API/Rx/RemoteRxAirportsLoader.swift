//
//  RemoteRxAirportsLoader.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 22/06/2021.
//

import Foundation
import RxSwift

final class RemoteRxAirportsLoader: AirportsLoader {
    private let client: RxHTTPClient
    private let url: URL
    private let disposeBag = DisposeBag()
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    init(url: URL, client: RxHTTPClient) {
        self.url = url
        self.client = client
    }
    
    func fetchAirports() -> Single<AirportsLoader.Result> {
        self.client.get(from: self.url, type: [RemoteAirports].self)
            .map({ $0.toModels() })
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result<AirportsLoader.Result, Swift.Error> {
        do {
            let items = try AirportsMapper.map(data, from: response)
            return .success(items.toModels())
        } catch {
            return .failure(error)
        }
    }
}

private extension Array where Element == RemoteAirports {
    func toModels() -> [Airport] {
        map {
            Airport(name: $0.name, city: $0.city, country: $0.country, iata_code: $0.iata_code, _geoloc: $0._geoloc.toModel(), objectID: $0.objectID)
        }
    }
}

private extension RemoteGeoloc {
    func toModel() -> Geoloc {
        Geoloc(lat: self.lat, lng: self.lng)
    }
}
