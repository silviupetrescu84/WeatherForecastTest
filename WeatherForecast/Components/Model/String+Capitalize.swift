//
//  String+Capitalize.swift
//  WeatherForecast
//
//  Created by Petrescu Silviu on 1/29/20.
//  Copyright © 2020Petrescu Silviu. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
