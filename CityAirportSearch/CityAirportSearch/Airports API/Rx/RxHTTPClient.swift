//
//  RxHTTPClient.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 23/06/2021.
//

import Foundation
import RxSwift

protocol RxHTTPClient {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func get<T: Decodable>(from url: URL, type: T.Type) -> Single<T>
}
