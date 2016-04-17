//
//  WeatherObserverTests.swift
//  WeatherObserverTests
//
//  Created by Olga Grineva on 17/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import XCTest

class WeatherObserverTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testParseJSON(){
        let fileName = "JsonResult.json"
        
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            
            let dirLocal = NSString(string: "/Users/olgagrineva/Documents/Code/weathertest/WeatherObserver/WeatherObserverTests")
            let path = dirLocal.stringByAppendingPathComponent(fileName);
        
            
            //reading
            do {
                let data = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMapped)
                
                do {
                
                    if let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String : AnyObject] {
                  
                        let parser = JsonParser()
                        let result = parser.getParsed(json)
                        print(result)
                    }
              
                
                } catch let error as NSError { print(error) }
            
            } catch let error as NSError { print(error) }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
