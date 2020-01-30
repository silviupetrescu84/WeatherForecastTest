//
//  WeatherForHourCell.swift
//  WeatherForecast
//
//  Created by Petrescu Silviu on 1/29/20.
//  Copyright © 2020Petrescu Silviu. All rights reserved.
//

import Foundation
import UIKit

class WeatherForHourCell : UITableViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    func update(data: WeatherData.List) {
        let date = Date(timeIntervalSince1970: data.dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Dublin")!
        let localDate = dateFormatter.string(from: date)
        
        hourLabel.text = localDate
        temperatureLabel.text = String(Int(round(data.main.temp))) + "°"
        descriptionLabel.text = data.weather[0].description.capitalizingFirstLetter()
        windLabel.text = String(Int(round(data.wind.speed))) + " m/s"
        humidityLabel.text = String(Int(round(data.main.humidity))) + " %"
        iconImageView.image = UIImage(named: data.weather[0].icon)
    }
}
