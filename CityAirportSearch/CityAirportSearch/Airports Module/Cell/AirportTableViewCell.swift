//
//  AirportTableViewCell.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 17/06/2021.
//

import UIKit

class AirportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var airportName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var geolocation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with viewModel: AirportTableViewModel) {
        airportName.text = viewModel.airportName
        city.text = viewModel.city
        country.text = viewModel.country
        geolocation.text = viewModel.geolocation
    }
    
}
