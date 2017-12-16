//
//  LineChartViewController.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/16/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {
    
    @IBOutlet weak var lineChart: LineChartView!
    
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
        
        updateChartTest()
        
    }
    
    var numbers: [Double] = [11,22,33,44,55,66,77,88,99,111,222,333,444,555,666,777,888,999]
    
    func updateChartTest() {
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i])
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number")
        line1.colors = [NSUIColor.blue]
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        lineChart.data = data
        lineChart.chartDescription?.text = "Description"
    }
    
    func updateChartWithData() {
        
        if let years = weatherDictionary["years"], let temperature = weatherDictionary["tmax"] {
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<years.count {
                let dataEntry = ChartDataEntry(x: years[i], y: temperature[i])
                dataEntries.append(dataEntry)
            }
            let chartDataSet = LineChartDataSet(values: dataEntries, label: "Year")
            let chartData = LineChartData(dataSet: chartDataSet)
            lineChart.data = chartData
        }
    }
    
}
