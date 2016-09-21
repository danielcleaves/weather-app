//
//  ViewController.swift
//  Web Service Application
//
//  Created by Daniel Cleaves on 9/20/16.
//  Copyright © 2016 Daniel Cleaves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var forecastLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.forecastLabel.text =  " "
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        
     let manager = AFHTTPSessionManager()
        
        manager.GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=Houston&mode=json&units=metric&cnt=1&appid=fb29fba5f3bb354d876120afef23ddbd",
                    parameters: nil,
                    progress: nil,
                    success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                        if let responseObject = responseObject {
                            print("Response: " + responseObject.description)
                            if let listOfDays = responseObject["list"] as? [AnyObject] {
                                if let tomorrow = listOfDays[0] as? [String:AnyObject] {
                                    if let tomorrowsWeather = tomorrow["weather"] as? [AnyObject] {
                                        if let firstWeatherOfDay = tomorrowsWeather[0] as? [String:AnyObject] {
                                            if let forecast = firstWeatherOfDay["description"] as? String {
                                                self.forecastLabel.text = forecast
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        activityIndicatorView.removeFromSuperview()
                        
            },
                    failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                        print("Error: " + error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

