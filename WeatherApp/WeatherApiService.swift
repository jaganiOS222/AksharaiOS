//
//  WeatherApiService.swift
//  WeatherApp
//
//  Created by apple on 04/02/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

protocol WeatherApiProtocal {
    func weatherData(_ lat:String,_ long:String,_ exclude:String,_ completion:@escaping Completion)
}

class WeatherApiService: DataService,WeatherApiProtocal {
    var lat:String = "",long:String = "",exclude:String = ""
    static let apiKey = "86162e07f5247b2a76897c17c2ddddb9"
  
    
    
    override func method() -> HttpMethod {
        .GET
    }
    
    override func baseURL() -> String {
        "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=\(exclude)&appid=\(WeatherApiService.apiKey)"
    }
    
    override func headers() -> [String : String] {
        return [
            HeaderField.contentType: ContentType.json
        ]
    }
    override func processData(response: Data) -> Any? {
        guard let weatherResponse = try? JSONDecoder().decode(Weather.self, from: response) else {
            return nil
        }
        return weatherResponse
    }
}


extension WeatherApiService {
    func weatherData( _ lat: String, _ long: String, _ exclude: String,_ completion:@escaping Completion) {
        self.lat = lat
        self.long = long
        self.exclude = exclude
          execute(completion: completion)
      }
}


struct Weather:Decodable {
    var lat:Float
    var timezone:String
    var lon:Float
    var current:CurrentWeather
}

struct CurrentWeather:Decodable {
    var temp:Float
    var dt:Float
    var sunrise:Float
    var sunset:Float
    var feels_like:Float
    
}
