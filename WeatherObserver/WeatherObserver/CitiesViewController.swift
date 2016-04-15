//
//  MasterViewController.swift
//  WeatherObserver
//
//  Created by Olga Grineva on 15/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import UIKit

class CitiesViewController: UITableViewController {

    var possibleCities = [City.Moscow, City.Astrakhan, City.SaintPetersburg]
    
    var detailViewController: WeatherInfoViewController? = nil
    var cities = [City]()
    
    let weather: [City : WeatherInfo] = [City.Moscow : WeatherInfo(description: "The weather is beatiful"), City.SaintPetersburg: WeatherInfo(description: "Rainy"), City.Astrakhan: WeatherInfo(description: "Warm")]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? WeatherInfoViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        
        if let nextCity = possibleCities.first {
            
            possibleCities.removeAtIndex(0)
            cities.insert(nextCity, atIndex: 0)
            
        }
        checkAddCityButtonState()
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let city = cities[indexPath.row] as! City
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! WeatherInfoViewController
                controller.detailItem = weather[city]
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
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

        let city = cities[indexPath.row] as! City
        cell.textLabel!.text = city.name()
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let city = cities.removeAtIndex(indexPath.row)
            possibleCities.append(city)
            checkAddCityButtonState()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    
    func checkAddCityButtonState(){
        
        self.navigationItem.rightBarButtonItem?.enabled = possibleCities.count > 0 ? true : false
    }

}

