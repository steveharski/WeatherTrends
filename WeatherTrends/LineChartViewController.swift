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
        
        if let searchedWeather = WeatherStore.cityWeather[city] {
            weatherDictionary = WeatherFormatter.weatherForChart(from: searchedWeather)
        }
        
        yAxisLabel = defaultYAxis
    }
    
    // MARK: SetUp
    func updateChart(yAxisKey: String, label: String) {
        
        if let years = weatherDictionary["years"],
            let yAxisValues = weatherDictionary[yAxisKey] {
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<years.count {
                let dataEntry = ChartDataEntry(x: years[i], y: yAxisValues[i])
                dataEntries.append(dataEntry)
            }
            let chartDataSet = LineChartDataSet(values: dataEntries, label: label)
            chartDataSet.colors = [WeatherFormatter.getChartColor(for: label) as NSUIColor]
            let chartData = LineChartData(dataSet: chartDataSet)
            lineChart.data = chartData
            lineChart.chartDescription?.text = ""
            lineChart.xAxis.labelPosition = .bottom
            lineChart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
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
