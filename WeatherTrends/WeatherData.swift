//
//  WeatherData.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/14/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import UIKit

class WeatherData {
    
    let metOffice = MetOfficeAPI()
    
    var years = [String]()
    var months = [String]()
    var tMax = [String]()
    var tMin = [String]()
    var afDays = [String]()
    var rainMM = [String]()
    var sunHours = [String]()
    
    
    func breakDataByComponents(from weatherString: String) {
        
            let fetchedDataCut = weatherString.components(separatedBy: "hours")
            let weatherDataString = fetchedDataCut[fetchedDataCut.count - 1]
            
            var weatherComponents = weatherDataString.components(separatedBy: "\n")
            weatherComponents.remove(at: 0)
            
            var components = [String]()
            
            for component in weatherComponents {
                let componentsArray = component.components(separatedBy: " ")
                for var comp in componentsArray {
                    if comp.count != 0 && comp.count < 10 {
                        if comp.contains("*") {
                            comp.remove(at: comp.index(of: "*")!)
                        }
                        components.append(comp)
                    }
                }
            }
            
            var counter = 1
            
            for i in components.indices {
                switch counter {
                case 1:
                    years.append(components[i])
                case 2:
                    months.append(components[i])
                case 3:
                    tMax.append(components[i])
                case 4:
                    tMin.append(components[i])
                case 5:
                    afDays.append(components[i])
                case 6:
                    rainMM.append(components[i])
                case 7:
                    sunHours.append(components[i])
                default:
                    print("Counter out of range")
                }
                
                counter += 1
                if counter > 7 {
                    counter = 1
                }
        }
        
        
    }
    
}
