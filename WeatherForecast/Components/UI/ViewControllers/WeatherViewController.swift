//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Petrescu Silviu on 1/29/20.
//  Copyright © 2020Petrescu Silviu. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var dataLoadIndicatorView: UIActivityIndicatorView!
    
    let weatherAPI = "https://api.openweathermap.org/data/2.5" //To do move to a network manager
    let endPoint = "/forecast"
    var orderedDays : [String] = [String]()
    var groupedData : [String:[WeatherData.List]] = [String:[WeatherData.List]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let city = "Dublin" //To do read user's location and use city based on that or allow user to choose
        let country = "IE" //To do read user's location and use country based on that or allow user to choose
        let units = "metric" //To do read user's settings on iDevice and set up according and also allow user to choose
        let weatherAPIKey = "9c12296762fdae996ae178e69890cfe0" //To do implement mechanism to download API key from a remote server to prevent abuse. If present in plist/code, API key can be used by anyone
        
        let parameters = ["q" : city + "," + country, "units" : units, "appid" : weatherAPIKey]
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        dataLoadIndicatorView.startAnimating()
        downloadWeatherData(parameters: parameters)
    }
   
    func downloadWeatherData(parameters: Dictionary <String,String> ) {
        guard let url = URL(string: weatherAPI + endPoint) else {
            print ("URL is not correct, please check code")
            return
        }
        AF.request(url, method: .get, parameters: parameters) //To do group in a network manager
            .validate()
            .responseDecodable(completionHandler: { (response: DataResponse<WeatherData>) in
                switch response.result {
                    case .success(let value):
                        self.groupWeatherByDays(with: value)
                    case .failure(let error):
                        print(error) //To do treat error codes
                }
                DispatchQueue.main.async {
                    self.dataLoadIndicatorView.stopAnimating()
                    self.showTable()
                }
            })
    }
    
    func groupWeatherByDays(with data: WeatherData) {
        //Extract the Day/Month in the dd/MM format from each date
        for i in 0..<(data.list.count) {
            let item = data.list[i]
            let date = Date(timeIntervalSince1970: item.dt)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            dateFormatter.timeZone = TimeZone(identifier: "Europe/Dublin")!
            let localDate = dateFormatter.string(from: date)
            data.list[i].day = localDate
            
            if orderedDays.firstIndex(of: localDate) == nil {
                orderedDays.append(localDate)
            }
        }
        
        //Initialize arrays for each date that contain the Weather.List objects for those dates
        for item in orderedDays {
            groupedData[item] = [WeatherData.List]()
        }
        
        //Group data into a dictionary that has the same keys as the odereredDays
        for item in data.list {
            let day = item.day as! String
            groupedData[day]?.append(item)
        }
    }
    
    func showTable () {
        weatherTableView.isHidden = false
        weatherTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < orderedDays.count {
            let day = orderedDays[section] as String
            return groupedData[day]?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherHeader") as! WeatherHeader
        cell.update(day: orderedDays[section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherTableCell") as! WeatherForHourCell
        let day = orderedDays[indexPath.section] as String
        let data = groupedData[day]![indexPath.row]
        cell.update(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

}

