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
        // Update the user interface for the detail item.
        
        
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
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

