//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var minTemperatureLabel: UILabel!
    @IBOutlet var maxTemperatureLabel: UILabel!
}

// MARK: ViewModel and pseudo-databinding
extension CurrentWeatherCell {
    struct ViewModel {
        let statusText: String
        let tempreature: String
        let feelsLike: String
        let minTemperature: String
        let maxTemperature: String
        
        init?(_ data: Weather.DataPoint?) {
            guard let data = data else { return nil }
            
            statusText = data.summary ?? ""
            tempreature = data.temperature.flatMap({ Double(Int($0.rounded())) })?.asCelsius.formatted ?? ""
            feelsLike = (data.apparentTemperature?.asCelsius.formatted).flatMap { "Feels like \($0)"} ?? ""
            minTemperature = (data.temperatureLow?.asCelsius.formatted).flatMap { "Min \($0)" } ?? ""
            maxTemperature = (data.temperatureHigh?.asCelsius.formatted).flatMap { "Max \($0)" } ?? ""
        }
    }
    
    func bind(_ viewModel: ViewModel) {
        statusLabel.text = viewModel.statusText
        temperatureLabel.text = viewModel.tempreature
        feelsLikeLabel.text = viewModel.feelsLike
        minTemperatureLabel.text = viewModel.minTemperature
        maxTemperatureLabel.text = viewModel.maxTemperature
    }
}
