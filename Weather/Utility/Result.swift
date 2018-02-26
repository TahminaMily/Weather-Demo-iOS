//
//  Result.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import Foundation

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}
