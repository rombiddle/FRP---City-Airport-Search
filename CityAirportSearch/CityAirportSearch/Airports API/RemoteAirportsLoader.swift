//
//  RemoteAirportsLoader.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 08/06/2021.
//

import Foundation
import RxSwift

final class RemoteAirportsLoader: AirportsLoader {
    private let client: HTTPClient
    private let url: URL
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func fetchAirports() -> Single<AirportsLoader.Result> {
        return Single.create { [weak self] single -> Disposable in
            guard let self = self else { return Disposables.create() }
            
            self.client.get(from: self.url) { result in
                switch result {
                case let .success((data, response)):
                    single(RemoteAirportsLoader.map(data, from: response))
                case .failure:
                    single(.failure(Error.connectivity))
                }
            }
            return Disposables.create()
        }
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
