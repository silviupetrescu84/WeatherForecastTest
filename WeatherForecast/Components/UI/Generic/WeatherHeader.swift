//
//  WeatherTableHeader.swift
//  WeatherForecast
//
//  Created by Petrescu Silviu on 1/29/20.
//  Copyright © 2020Petrescu Silviu. All rights reserved.
//

import Foundation
import UIKit

class WeatherHeader : UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    
    func update (day: String) {
        dayLabel.text = "Date: " + day
    }
}
