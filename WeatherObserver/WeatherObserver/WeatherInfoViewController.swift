//
//  DetailViewController.swift
//  WeatherObserver
//
//  Created by Olga Grineva on 15/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import UIKit

class WeatherInfoViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    var detailItem: WeatherInfo? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func updatingData(){
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = "data is updating"
            }
        }
    }

    func configureView() {
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
            if let pressure = self.pressureLabel, let pressureData = detail.pressure {
                pressure.text = String(pressureData)
            }
            if let temp = self.tempLabel, let tempData = detail.temperature {
                temp.text = String(tempData)
            }
            if let sunset = self.sunsetLabel, let sunsetData = detail.sunset {
                sunset.text = String(sunsetData)
            }
            if let sunrise = self.sunriseLabel, let sunriseData = detail.sunrise {
                sunrise.text = String(sunriseData)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WeatherInfoViewController.updatingData), name: "updating", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WeatherInfoViewController.configureView), name: "updated", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

