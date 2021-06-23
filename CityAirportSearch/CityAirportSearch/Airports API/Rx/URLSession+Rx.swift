//
//  URLSession+Rx.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 22/06/2021.
//

import Foundation
import RxSwift

enum RxURLSessionError: Error {
    case unknown
    case invalidResponse(response: URLResponse)
}

extension Reactive where Base: URLSession {
    func decodable<D: Decodable>(request: URLRequest, type: D.Type) -> Observable<D> {
        return data(request: request).map { data in
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        }
    }
}
