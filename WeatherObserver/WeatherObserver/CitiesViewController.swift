//
//  MasterViewController.swift
//  WeatherObserver
//
//  Created by Olga Grineva on 15/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import UIKit

class CitiesViewController: UITableViewController {

    @IBAction func refreshClicked(sender: AnyObject) {
        getWeatherData()
    }
    
    private var dataProvider: WeatherDataProviderProtocol = WeatherDataProvider()
    private var jsonParser = JsonParser()
    
    var detailViewController: WeatherInfoViewController? = nil
    var cities = [City.Moscow, City.SaintPetersburg, City.Astrakhan, City.Chelyabinsk, City.Cherepovets, City.Izhevsk, City.NizhniyNovgorod, City.RespublikaKareliya, City.Nakhodka, City.Taganrog]
    var weather: [City : WeatherInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? WeatherInfoViewController
        }
 
        getWeatherData()
    }
    
    
    private func getWeatherData(){
        NSNotificationCenter.defaultCenter().postNotificationName("updating", object: nil)
        weather = nil
        
        dataProvider.getCurrentWeather(cities){
            (result, status) in
            
            dispatch_async(dispatch_get_main_queue()){
                switch status {
                case .Success:
                    guard let result = result else {
                        self.showAlert(UIMessages.NoData.rawValue)
                        return
                    }
                    
                    dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)) {
                        self.weather = self.jsonParser.getParsed(result){
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                NSNotificationCenter.defaultCenter().postNotificationName("updated", object: nil)
                            }
                        }
                    }
                
                case .BadRequest:
                    self.showAlert(UIMessages.BadRequest.rawValue)
                
                case .NotFound:
                    self.showAlert(UIMessages.NotFound.rawValue)
                    
                case .NoInternet:
                    self.showAlert(UIMessages.NoInternetConnection.rawValue)
                    
                case .UnknownErorr:
                    self.showAlert(UIMessages.UnknownError.rawValue)
                    
                default: break
                }
            }
        }
    }

    private func showAlert(message: String){
        let alertController = UIAlertController(title: "Info", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let city = cities[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if let cellLabel = cell.textLabel {
            cellLabel.text = city.name()
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

