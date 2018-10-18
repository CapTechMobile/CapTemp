//
//  WeatherCell.swift
//  CapAir
//
//  Created by Alan Shih on 10/1/18.
//  Copyright © 2018 CapTech. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var percipTypeImageView: UIImageView!
    
    @IBOutlet weak var percipProbLabel: UILabel!
    
}
