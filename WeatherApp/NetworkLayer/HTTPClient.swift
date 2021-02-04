//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by apple on 04/02/21.
//  Copyright © 2021 apple. All rights reserved.
//

import Foundation

typealias Handler = (Data?, URLResponse?, Error?) -> Void

class HTTPClient {
    
    private var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func load(path: String,
              method: HttpMethod,
              headers: [String: String]?,
              params: [String: String]?,
              body: Data?,
              completion: @escaping Handler) -> URLSessionDataTask? {
        let request = URLRequest(baseUrl: baseUrl, path: path, method: method, headers: headers, params: params, body: body)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                completion(data, response, error)
            } else if let error = error {
                completion(data, response, error)
            }
        }
        
        task.resume()
        
        return task
    }
}

extension URLRequest {
    
    init(baseUrl: String, path: String,
         method: HttpMethod,
         headers: [String: String]? = [:],
         params: [String: String]? = [:],
         body: Data?) {
        
        let url = URL(baseUrl: baseUrl, path: path, method: method, params: params)
        self.init(url: url)
        httpMethod = method.rawValue
        addHeaders(headers: headers!)
        cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        switch method {
        case .POST, .PUT, .PATCH:
            if let body = body {
                httpBody = body
            }
        default:
            break
        }
        
    }
    
    mutating func addHeaders(headers: [String:String]) {
        
        for header in headers {
            addValue(header.value, forHTTPHeaderField: header.key)
        }
        
    }
}

extension URL {
    
    init(baseUrl: String, path: String, method: HttpMethod, params: [String: String]?) {
        var components = URLComponents(string: baseUrl)!
        components.path += path
        
        switch method {
        case .GET, .DELETE:
            if let requestParams = params {
                components.queryItems = requestParams.map {
                    URLQueryItem(name: $0.0, value: String(describing: $0.1))
                }
            }
        default:
            break
        }
        
        self = components.url!
    }
}
