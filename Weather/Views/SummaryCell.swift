//
//  SummaryCell.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import UIKit

class SummaryCell: UITableViewCell {
    @IBOutlet var summaryLabel: UILabel!
}

// MARK: ViewModel and pseudo-databinding
extension SummaryCell {
    struct ViewModel {
        let summary: String
        
        init?(_ data: Weather.DataPoint?) {
            guard let summary = data?.summary else { return nil }
            var summaryText = "Today: " + summary
            if let humidity = data?.humidity {
                summaryText += " Humidity \(Int(humidity*100))%."
            }
            if let precipProbability = data?.precipProbability, let precipType = data?.precipType {
                summaryText += " Chance of \(precipType.rawValue) \(Int(precipProbability*100))%."
            }
            //more can be added like sunrise and sunset time, UV index, moonphase etc.
            self.summary = summaryText
        }
    }
    
    func bind(_ viewModel: ViewModel) {
        summaryLabel.text = viewModel.summary
    }
}
