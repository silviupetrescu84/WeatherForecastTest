//
//  Weather.swift
//  WeatherForecast
//
//  Created by Petrescu Silviu on 1/29/20.
//  Copyright © 2020Petrescu Silviu. All rights reserved.
//

import Foundation

class WeatherData : Codable {
    let cod: String
    let message: Double
    let city: City
    let cnt: Int
    var list:[List] = [List]()
    
    struct City: Codable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        
        struct Coord: Codable {
            let lat: Double
            let lon: Double
        }
    }
    
    struct List: Codable {
        let dt: Double
        let main: Main
        var weather: [Weather] = [Weather]()
        let clouds: Clouds
        let wind: Wind
        let dt_txt: String
        var day: String? = ""
        
        struct Main: Codable {
            let temp: Double
            let temp_min: Double
            let temp_max: Double
            let pressure: Double
            let sea_level: Double
            let grnd_level: Double
            let humidity: Double
            let temp_kf: Double
        }
        
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Clouds: Codable {
            let all: Int
        }
        
        struct Wind: Codable {
            let speed: Double
            let deg: Double
        }
        struct sys: Codable {
            let pod: String
        }
    }
}
