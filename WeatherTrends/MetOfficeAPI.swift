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
        return URL(string: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/\(city.lowercased())data.txt")
    }
    
}
