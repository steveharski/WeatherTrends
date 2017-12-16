//
//  Weather.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/16/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import Foundation

class Weather {
    
    let city: String
    let history: String
    
    init(city: String, history: String) {
        self.city = city
        self.history = history
    }
    
    
    static func weatherForTable(from fetchedWeather: String) -> [String] {
        
        let seperatedFetchedWeather = fetchedWeather.components(separatedBy: "hours")
        let weatherValues = seperatedFetchedWeather[seperatedFetchedWeather.count - 1]
        
        var seperatedWeatherValues = weatherValues.components(separatedBy: "\n")
        seperatedWeatherValues.remove(at: 0)
        
        /*
        var trimmedWeather = [String]()
        for yearMonthValues in seperatedWeatherValues {
            let trimmedValue = yearMonthValues.trimmingCharacters(in: .whitespaces)
            trimmedWeather.append(trimmedValue)
        }
        return trimmedWeather*/
       return seperatedWeatherValues
    }
}
