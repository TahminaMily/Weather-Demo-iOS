//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import UIKit

class DailyWeatherCell: UITableViewCell {
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var temperatureHighLabel: UILabel!
    @IBOutlet var temperatureLowLabel: UILabel!
}

// MARK: ViewModel and pseudo-databinding
extension DailyWeatherCell {
    struct ViewModel {
        let day: String
        let temperatureHigh: String
        let iconName: String
        let temperatureLow: String
        
        init?(_ data: Weather.DataPoint?) {
            guard let data = data else { return nil }
            
            day = Formatters.day.string(from: Date(timeIntervalSince1970: data.time))
            iconName = data.icon?.rawValue ?? ""
            temperatureHigh = data.temperatureHigh.flatMap { String.init(format: "%.0f", $0) } ?? ""
            temperatureLow = data.temperatureLow.flatMap { String.init(format: "%.0f", $0) } ?? ""
        }
    }
    
    func bind(_ viewModel: ViewModel) {
        dayLabel.text = viewModel.day
        iconImageView.image = UIImage(named: viewModel.iconName)
        temperatureHighLabel.text = viewModel.temperatureHigh
        temperatureLowLabel.text = viewModel.temperatureLow
    }
}
