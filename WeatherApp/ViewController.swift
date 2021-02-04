//
//  ViewController.swift
//  WeatherApp
//
//  Created by apple on 04/02/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var weatherApiService = WeatherApiService.init()
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        currentLoc = locationManager.location
        gettingData()
        
    }

    func gettingData() {
      
        if let lat = currentLoc?.coordinate.latitude,
            let long = currentLoc?.coordinate.longitude {
            weatherApiService.weatherData("\(lat)", "\(long)", "hourly,daily") { (result) in
                
            }
        }
        
    }

}

