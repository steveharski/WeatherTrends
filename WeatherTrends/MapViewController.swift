//
//  MapViewController.swift
//  WeatherTrends
//
//  Created by Adminaccount on 12/15/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    
    @IBAction func showWeather(_ sender: UIButton) {
        performSegue(withIdentifier: "showHistory", sender: sender)
    }
    
    // MARK: Rotation
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showHistory"?:
            let tabBarController = segue.destination as! UITabBarController
            let historyViewController = tabBarController.viewControllers![0] as! HistoryViewController
            if let buttonTitle = (sender as? UIButton)?.currentTitle {
               historyViewController.city = buttonTitle
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
}
