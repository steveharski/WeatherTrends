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
    
    var city: String {
        get {
            return (self.tabBarController!.viewControllers![0] as! HistoryViewController).city!
        }
    }
    
    var weatherDictionary = [String:[Double]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.navigationItem.title = city
        weatherDictionary = WeatherFormatter.weatherForChart(from: WeatherStore.cityWeather[city]!)
        updateChartWithData()
    }
    
    
    func updateChartWithData() {
        
        if let years = weatherDictionary["years"],
            let temperature = weatherDictionary["tmax"] {
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
    
    
}
