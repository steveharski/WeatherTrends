//
//  WeatherStore.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/16/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import Foundation

enum WeatherResult {
    case success(String)
    case failure(Error)
}

enum WeatherError: Error {
    case weatherCreationError
}

class WeatherStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    static var cityWeather = [String:String]()
    
    func fetchWeather(for city: String, completion: @escaping (WeatherResult) -> Void) {
        let url = MetOfficeAPI.getURL(for: city)
        let request = URLRequest(url: url!)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            let result = self.processWeatherRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func processWeatherRequest(data: Data?, error: Error?) -> WeatherResult {
        guard let weatherData = data, let weather = String(data: weatherData, encoding: .utf8) else {
            if data == nil {
                return .failure(error!)
            } else {
                return .failure(WeatherError.weatherCreationError)
            }
        }
        return .success(weather)
    }
    
    
}
