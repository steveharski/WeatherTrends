//
//  MetOfficeAPI.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/14/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import UIKit

class MetOfficeAPI {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
   // var weatherHistoryData = WeatherData()
    
    func fetchWeatherHistory() {
        let url = URL(string: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if error != nil {
                print(error as Any)
            } else {
                if data != nil {
                    self.keepDoingStaff(with: data!)
                }
            }
        }
        task.resume()
    }
    
    
    func keepDoingStaff(with data: Data) {
        if let weatherDataString = String(data: data, encoding: .utf8) {
            print("Success")
            print(weatherDataString)
           // weatherHistoryData.breakDataByComponents(from: weatherDataString)
        }
    }
    
}
