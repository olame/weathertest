//
//  MasterViewController.swift
//  WeatherObserver
//
//  Created by Olga Grineva on 15/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import UIKit

class CitiesViewController: UITableViewController {

    private var dataProvider: WeatherDataProviderProtocol?
    private var jsonParser: JsonParser?
    
    var detailViewController: WeatherInfoViewController? = nil
    var cities = [City.Moscow, City.SaintPetersburg, City.Astrakhan, City.Chelyabinsk, City.Cherepovets, City.Izhevsk, City.NizhniyNovgorod, City.RespublikaKareliya, City.Nakhodka, City.Taganrog]
    
//    let weather: [City : WeatherInfo] = [City.Moscow : WeatherInfo(description: "The weather is beatiful"), City.SaintPetersburg: WeatherInfo(description: "Rainy"), City.Astrakhan: WeatherInfo(description: "Warm")]
    var weather: [City : WeatherInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //add cities here
        for _  in 1...cities.count {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? WeatherInfoViewController
        }
        
        //start to load data
        if dataProvider == nil {
            
            dataProvider = WeatherDataProvider()
        }
        if jsonParser == nil {
            jsonParser = JsonParser()
        }
        
        dataProvider?.getCurrentWeather(cities){
            (result, status) in
            
            dispatch_async(dispatch_get_main_queue()){
                switch status {
                    case StatusCode.Success:
                        self.weather = self.jsonParser?.getParsed(result!)
                    case StatusCode.NoInternet:
                        self.showAlert(UIMessages.NoInternetConnection.rawValue)
                    
                    case StatusCode.UnknownErorr:
                        self.showAlert(UIMessages.UnknownError.rawValue)
                    
                    default: break
                }
            }
        }
    }

    private func showAlert(message: String){
        let alertController = UIAlertController(title: "Info", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        //Delay the dismissal by 1 seconds
        let delay = 3.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            alertController.dismissViewControllerAnimated(false, completion: nil)
        })
    
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let city = cities[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! WeatherInfoViewController
                controller.detailItem = weather?[city]
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let city = cities[indexPath.row] 
        cell.textLabel!.text = city.name()
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


}

