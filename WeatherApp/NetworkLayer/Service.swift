//
//  Service.swift
//  WeatherApp
//
//  Created by apple on 04/02/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

typealias Completion = (Result<Any>) -> Void

class Service: NSObject {
    
    func processData(response: Data) -> Any? {
        return nil
    }
    
    func cancel() { }
    
    func execute(completion: @escaping Completion) { }
}

enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
    case PATCH = "PATCH"
}

enum HeaderField {
    static let accept               = "Accept"
    static let authorization        = "Authorization"
    static let authentication       = "Authentication"
    static let contentType          = "Content-Type"
    static let jsonContentType      = "application/json"
    static let atomApiKey           = "atom-api-key"
}

enum ContentType {
    static let json = "application/json"
    static let form = "application/x-www-form-urlencoded;charset=utf-8"
}
