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
    
    var yAxisLabel: String? {
        didSet {
            if let key = WeatherFormatter.getWeatherKey(from: self.yAxisLabel!) {
            updateChart(yAxisKey: key, label: self.yAxisLabel!)
            }
        }
    }
    
    var defaultYAxis = "max temperature Cº"
    
    var weatherDictionary = [String:[Double]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.navigationItem.title = city
        
        // Check if weather is fetched already
        if let searchedWeather = WeatherStore.cityWeather[city] {
        weatherDictionary = WeatherFormatter.weatherForChart(from: searchedWeather)
        }
        
        yAxisLabel = defaultYAxis
    }
    
    
    func updateChart(yAxisKey: String, label: String) {
        
        if let years = weatherDictionary["years"],
            let yAxisValues = weatherDictionary[yAxisKey] {
            var dataEntries: [BarChartDataEntry] = []
            for i in 0..<years.count {
                let dataEntry = BarChartDataEntry(x: years[i], y: yAxisValues[i])
                dataEntries.append(dataEntry)
            }
            let chartDataSet = BarChartDataSet(values: dataEntries, label: label)
            let chartData = BarChartData(dataSet: chartDataSet)
            barChart.data = chartData
        }
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "popOver"?:
            let destination = segue.destination as! OptionsPopUpViewController
            destination.chosenOption = yAxisLabel
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func unwindFromOptionsVC(_ sender: UIStoryboardSegue) {
        if sender.source is OptionsPopUpViewController {
            if let senderVC = sender.source as? OptionsPopUpViewController {
                self.yAxisLabel = senderVC.chosenOption
            }
        }
    }
    
}
