//
//  WeatherFormatter.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/16/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import Foundation
import UIKit

class WeatherFormatter {
    
    // MARK: Table
    static func weatherForTable(from fetchedWeather: String) -> [String] {
        
        // Separate header and weather history
        let separatedFetchedWeather = fetchedWeather.components(separatedBy: "hours")
        let weatherValues = separatedFetchedWeather[separatedFetchedWeather.count - 1]
        
        var separatedWeatherValues = weatherValues.components(separatedBy: "\n")
        separatedWeatherValues.remove(at: 0)
        
        
        for i in separatedWeatherValues.indices {
            var row = separatedWeatherValues[i]
            // Remove "*" nad "#" from a row
            for character in row {
                if character == "*" {
                    row.remove(at: row.index(of: "*")!)
                } else if character == "#" {
                    row.remove(at: row.index(of: "#")!)
                }
            }
            // Remove 'Provisional' from a row
            if row.contains("Provisional") {
                row.removeSubrange(row.range(of: "Provisional")!)
            }
            separatedWeatherValues[i] = row
        }
        
       return separatedWeatherValues
    }
    
    
    // MARK: Charts
    static func weatherForChart(from fetchedWeather: String) -> [String:[Double]] {
        let tableWeather = weatherForTable(from: fetchedWeather)
        
        var weatherValues = [String]()
        
        // Break up rows for separate values
        // Remove occurance of '\r'
        for valuesRow in tableWeather {
            let valuesArray = valuesRow.components(separatedBy: " ")
            for var component in valuesArray {
                if component.contains("\r") {
                        component.remove(at: component.index(of: "\r")!)
                    }
                    weatherValues.append(component)
                }
            }
        
         var years = [Double]()
         var tMax = [Double]()
         var tMin = [Double]()
         var afDays = [Double]()
         var rainMM = [Double]()
         var sunHours = [Double]()
         
        var counter = 1
        
        // Store values into arrays by its meaning
        for i in weatherValues.indices {
            
            if weatherValues[i].count != 0 {
    
            switch counter {
            case 1:
                if let year = Double(weatherValues[i]) {
                    if !years.contains(year) {
                        years.append(year)
                    }
                }
            case 2:
                break
            case 3:
                (Double(weatherValues[i]) != nil) ? tMax.append(Double(weatherValues[i])!) : tMax.append(0)
            case 4:
                (Double(weatherValues[i]) != nil) ? tMin.append(Double(weatherValues[i])!) : tMin.append(0)
            case 5:
                (Double(weatherValues[i]) != nil) ? afDays.append(Double(weatherValues[i])!) : afDays.append(0)
            case 6:
                (Double(weatherValues[i]) != nil) ? rainMM.append(Double(weatherValues[i])!) : rainMM.append(0)
            case 7:
                (Double(weatherValues[i]) != nil) ? sunHours.append(Double(weatherValues[i])!) : sunHours.append(0)
            default:
                print("Counter out of range")
            }
            
            counter += 1
            if counter > 7 {
                counter = 1
            }
            }
        }
        
        return ["years": years, "tmax": getAverageYearlyValues(from: tMax),
                "tmin": getAverageYearlyValues(from: tMin),
                "af": getAverageYearlyValues(from: afDays),
                "rain": getAverageYearlyValues(from: rainMM),
                "sun": getAverageYearlyValues(from: sunHours)]
    }
    
    
    
    static func getAverageYearlyValues(from values: [Double]) -> [Double] {
        var averageValues = [Double]()
        var avarageValue = Double()
        var counter = 0
        for i in values.indices {
            avarageValue += values[i]
            counter += 1
            
            if counter >= 12 {
                averageValues.append(avarageValue/Double(counter))
                avarageValue = 0
                counter = 0
            } else if i == values.count - 1 {
                averageValues.append(avarageValue/Double(counter))
            }
        }
        
        return averageValues
    }
    
    static func getWeatherKey(from label: String) -> String? {
        switch label {
        case "max temperature Cº":
            return "tmax"
        case "min temperature Cº":
            return "tmin"
        case "average frost days":
            return "af"
        case "rain mm":
            return "rain"
        case "sun days":
            return "sun"
        default:
            return nil
        }
    }
    
    // MARK: Charts colors
    static func getChartColor(for label: String) -> UIColor {
        switch label {
        case "max temperature Cº":
            return #colorLiteral(red: 0.8640807271, green: 0.3032546937, blue: 0.09520091861, alpha: 1)
        case "min temperature Cº":
            return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case "average frost days":
            return #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case "rain mm":
            return #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        case "sun days":
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        default:
            return #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        }
    }
    
    
    
}
