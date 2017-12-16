//
//  WeatherFormatter.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/16/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import Foundation

class WeatherFormatter {
    
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
    
    
    static func weatherForChart(from fetchedWeather: String) -> [String:[Double]] {
        let tableWeather = weatherForTable(from: fetchedWeather)
        
        var weatherValues = [String]()
        
        for valuesRow in tableWeather {
            let valuesArray = valuesRow.components(separatedBy: " ")
            for var component in valuesArray {
                if component.count != 0 && component.count < 10 {
                    if component.contains("*") {
                        component.remove(at: component.index(of: "*")!)
                    }
                    weatherValues.append(component)
                }
            }
        }
        
         var years = [Double]()
         var tMax = [Double]()
         var tMin = [Double]()
         var afDays = [Double]()
         var rainMM = [Double]()
         var sunHours = [Double]()
         
        var counter = 1
        
        for i in weatherValues.indices {
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
    
    
    
    
    
    
}
