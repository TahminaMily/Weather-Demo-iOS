//
//  HourlyWeatherItemCell.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import UIKit

class HourlyWeatherItemCell: UICollectionViewCell {
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
}

// MARK: ViewModel and pseudo-databinding
extension HourlyWeatherItemCell {
    struct ViewModel {
        let time: String
        let iconName: String
        let temperature: String
        
        init(_ data: Weather.DataPoint) {
            time = Formatters.time.string(from: Date(timeIntervalSince1970: data.time))
            iconName = data.icon?.rawValue ?? ""
            temperature = data.temperature.flatMap({ Double(Int($0.rounded()))})?.asCelsius.formatted ?? ""
        }
    }
    
    func bind(_ viewModel: ViewModel) {
        timeLabel.text = viewModel.time
        iconImageView.image = UIImage(named: viewModel.iconName)
        temperatureLabel.text = viewModel.temperature
    }
}
