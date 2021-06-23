//
//  URLSessionRxHTTPClient.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 22/06/2021.
//

import Foundation
import RxSwift

class URLSessionRxHTTPClient: RxHTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    struct UnexpectedValuesRepresentation: Error {}
    
    func get<T: Decodable>(from url: URL, type: T.Type) -> Single<T> {
        session
            .rx
            .decodable(request: URLRequest(url: url), type: T.self)
            .asSingle()
    }
}
