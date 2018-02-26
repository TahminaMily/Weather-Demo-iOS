//
//  Models.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import Foundation

//this enum is just providing namespace
enum Weather {
    static let webserviceURL = URL(string: "https://api.darksky.net/forecast/0c6e70d1ab343ed99564bbcc620b81e1/-33.8650,151.2094?units=si")!
    
    struct Forecast: Codable {
        let latitude: Double
        let longitude: Double
        let timezone: String
        
        let currently: DataPoint?
        let minutely: DataBlock?
        let hourly: DataBlock?
        let daily: DataBlock?
    }
    
    struct DataPoint: Codable {
        let apparentTemperature: Double?
        let apparentTemperatureHigh: Double?
        let apparentTemperatureHighTime: TimeInterval?
        let apparentTemperatureLow: Double?
        let apparentTemperatureLowTime: TimeInterval?
        let cloudCover: Double?
        let dewPoint: Double?
        let humidity: Double?
        let icon: Icon?
        let moonPhase: Double?
        let nearestStormBearing: Double?
        let nearestStormDistance: Double?
        let ozone: Double?
        let precipAccumulation: Double?
        let precipIntensity: Double?
        let precipIntensityMax: Double?
        let precipIntensityMaxTime: TimeInterval?
        let precipProbability: Double?
        let precipType: PrecipType?
        let pressure: Double?
        
        let summary: String?
        let sunriseTime: TimeInterval?
        let sunsetTime: TimeInterval?
        let temperature: Double?
        let temperatureHigh: Double?
        let temperatureHighTime: TimeInterval?
        let temperatureLow: Double?
        let temperatureLowTime: TimeInterval?
        
        let time: TimeInterval
        let uvIndex: Int?
        let uvIndexTime: TimeInterval?
        let visibility: Double?
        let windBearing: Double?
        let windGust: Double?
        let windSpeed: Double?
    }
    
    struct DataBlock: Codable {
        let data: [DataPoint]
        let summary: String?
        let icon: Icon?
    }
    
    enum Icon: String, Codable {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
    }
    
    enum PrecipType: String, Codable {
        case rain
        case snow
        case sleet
    }
}
