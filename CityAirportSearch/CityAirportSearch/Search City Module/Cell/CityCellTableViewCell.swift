//
//  CityCellTableViewCell.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 15/06/2021.
//

import UIKit

class CityCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModel: CityCellViewModel) {
        cityLabel.text = viewModel.city
        locationLabel.text = viewModel.location
    }
    
}
