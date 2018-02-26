//
//  Formatters.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import Foundation

// bunch of Formatters that are used in the app
enum Formatters {
    static var temperature = MeasurementFormatter()
    static var day: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    static var time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter
    }()
}

extension Double {
    var asCelsius: Measurement<UnitTemperature> {
        return Measurement(value: self, unit: UnitTemperature.celsius)
    }
}

extension Measurement where UnitType == UnitTemperature {
    var formatted: String {
        return Formatters.temperature.string(from: self)
    }
}
