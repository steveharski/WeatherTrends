//
//  OptionsPopUpViewController.swift
//  WeatherTrends
//
//  Created by Steve Harski on 12/17/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import UIKit

class OptionsPopUpViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var tapBGGesture: UITapGestureRecognizer!
    
    var chosenOption: String?
    
    @IBAction func chooseOption(_ sender: UIButton) {
        self.chosenOption = sender.titleLabel?.text
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var options: [UIButton]!
    
    // MARK: overriding view functions
    override func viewWillAppear(_ animated: Bool) {
        updateSelectedOption()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tapBGGesture = UITapGestureRecognizer(target: self, action: #selector(tapBG))
        tapBGGesture.delegate = self
        tapBGGesture.numberOfTapsRequired = 1
        tapBGGesture.cancelsTouchesInView = false
        self.view.window!.addGestureRecognizer(tapBGGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.window!.removeGestureRecognizer(tapBGGesture)
    }
    
    // MARK: class functions
    @objc func tapBG(sender: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    private func updateSelectedOption() {
        for button in options {
            if let option = chosenOption, button.titleLabel?.text == option {
                button.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }

}

