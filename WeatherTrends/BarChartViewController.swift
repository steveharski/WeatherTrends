//
//  BarChartViewController.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/14/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {
    
    
    @IBOutlet weak var barChart: BarChartView!
    
    let weatherData = WeatherData()
    
    var years: [Double] = [1908, 1909, 1910, 1911, 1912, 1913, 1914]
    
    var temperature: [Double] = [23.4, 28.7, 20.3, 23, 24, 19.5, 21.3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateChartWithData()
        
       // weatherData.metOffice.fetchWeatherHistory()
       // print(weatherData.years)
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<years.count {
            let dataEntry = BarChartDataEntry(x: years[i], y: temperature[i])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Year")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.data = chartData
    }
    
    
}
