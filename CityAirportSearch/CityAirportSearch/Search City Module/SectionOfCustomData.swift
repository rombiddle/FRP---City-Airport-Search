//
//  SectionOfCustomData.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 10/06/2021.
//

import Foundation
import RxDataSources

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = Airport
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
