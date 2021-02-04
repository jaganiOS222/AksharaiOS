//
//  Result.swift
//  WeatherApp
//
//  Created by apple on 04/02/21.
//  Copyright © 2021 apple. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
    case apiFailure(Value)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        case .apiFailure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        case .apiFailure(let value):
            return value
        }
    }
        
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        case .apiFailure:
            return nil
        }
    }
}
