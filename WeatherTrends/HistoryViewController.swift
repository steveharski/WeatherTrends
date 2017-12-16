//
//  HistoryViewController.swift
//  WeatherTrends
//
//  Created by Adminaccount on 12/15/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var city: String!
    
    let weatherStore = WeatherStore()
    
    var weatherHistory = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tabBarController?.navigationItem.title = city
        
        // not sure about this one
        if let searchedWeather = WeatherStore.cityWeather[city] {
            print("Getting stored weather")
            weatherHistory = WeatherFormatter.weatherForTable(from: searchedWeather)
        } else {
        print("Fetching weather")
       self.updateWeatherView(for: city)
        }
    }
    
    
    func updateWeatherView(for city: String) {
        weatherStore.fetchWeather(for: city) {
            (weatherResult) in
            
            switch weatherResult {
            case let .success(weather):
                WeatherStore.cityWeather[city] = weather
                self.weatherHistory = WeatherFormatter.weatherForTable(from: weather)
                self.tableView.reloadData()
            case let .failure(error):
                print("Error occured: \(error)")
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let item = weatherHistory[indexPath.row]
        
        cell.textLabel?.text = item
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = "yyyy  mm   tmax    tmin      af    rain     sun\n                  degC   degC   days  mm hours"
        header.numberOfLines = 0
        header.lineBreakMode = .byWordWrapping
        header.sizeToFit()
        header.textAlignment = .center
        header.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        return header
    }
        
    
}
