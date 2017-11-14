//
//  DataAnalysisViewController.swift
//  Temperature Calculator

//  Created by Harshitha Tadinada on 10/7/2017.
//  Copyright © 2017 UGA. All right
//

import UIKit

class DataAnalysisViewController: UIViewController {
    let prev = PreviewViewController()
    
    public var temp: Double = 0.0;
    @IBOutlet weak var sendToNetwork: UIButton!
    @IBOutlet weak var currentLocation: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temp = prev.getTemperature()
        sendToNetwork.layer.cornerRadius = 5
        currentLocation.layer.cornerRadius = 5
        tempLabel.text = "\(String(temp))° F"
        tempLabel.font = UIFont.boldSystemFont(ofSize: 70)
    }
}
