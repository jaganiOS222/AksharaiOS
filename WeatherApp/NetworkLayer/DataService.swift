//
//  DataService.swift
//  WeatherApp
//
//  Created by apple on 04/02/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class DataService: Service {
    
    private(set) var dataTask: URLSessionDataTask?
    
    
    
    func method() -> HttpMethod {
        return .POST
    }
    
    func params() -> [String: String]? {
        return nil
    }
    
    func body() -> Data? {
        return nil
    }
    
    func headers() -> [String: String] {
        return [:]
    }
    
    func baseURL() -> String {
        return ""
    }
    
    func endPoint() -> String {
        return ""
    }
    
    func mockPath() -> String {
        return ""
    }
    
  
    
    override func cancel() {
        if let task = dataTask {
            task.cancel()
        }
    }
    
    override func execute(completion: @escaping Completion) {
        
       
        
        let client = HTTPClient(baseUrl: baseURL())
        dataTask = client.load(path: endPoint(), method: method(), headers: headers(), params: params(), body: body(),
                               completion: { [weak self]
                                (data, response, error) in
                                
                                DispatchQueue.main.async(execute: {
                                    guard error == nil else {
                                        let result = Result<Any>.failure(error!)
                                        completion(result)
                                        return
                                    }
                                    if let httpResponse = response as? HTTPURLResponse {
                                        if httpResponse.statusCode != 200 {
                                            if let error = error?.localizedDescription as? Error {
                                                let result = Result<Any>.failure(error)
                                                completion(result)
                                                return
                                            }
                                            
                                        }
                                    }
                                   
                                    if let obj = self?.processData(response: data!) {
                                        let result = Result<Any>.success(obj)
                                        completion(result)
                                        return
                                    }
                                    
                                    let result = Result<Any>.apiFailure("Response parsing failed")
                                    completion(result)
                                })
        })
    }
    
}

