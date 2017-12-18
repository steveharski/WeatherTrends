//
//  MetOfficeAPI.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/14/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import Foundation

class MetOfficeAPI {
    
    static func getURL(for city: String) -> URL? {
        let formattedCity = self.formatCity(from: city)
        return URL(string: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/\(formattedCity)data.txt")
    }
    
    // Format city as expected in url
    private static func formatCity(from cityToFormat: String) -> String {
        var city = cityToFormat.lowercased()
        for character in city {
            if character == "-" {
                city.remove(at: city.index(of: "-")!)
            } else if character == " " {
                city.remove(at: city.index(of: " ")!)
            }
        }
        return city
    }
}
