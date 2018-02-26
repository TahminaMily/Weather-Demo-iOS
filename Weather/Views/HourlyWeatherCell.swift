//
//  HourlyWeatherCell.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import UIKit

class HourlyWeatherCell: UITableViewCell {
    @IBOutlet var collectionView: UICollectionView!
    var viewModel: ViewModel?
}

// MARK: ViewModel and pseudo-databinding
extension HourlyWeatherCell {
    struct ViewModel {
        let dataPoints: [Weather.DataPoint]
        init?(_ data: Weather.DataBlock?) {
            guard let data = data else { return nil }
            dataPoints = data.data
        }
    }
    
    func bind(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension HourlyWeatherCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.dataPoints.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherItemCell.reuseIdentifier, for: indexPath)
        guard
            let cell = collectionViewCell as? HourlyWeatherItemCell,
            let point = viewModel?.dataPoints[indexPath.row]
        else {
            return collectionViewCell
        }
        cell.bind(HourlyWeatherItemCell.ViewModel(point))
        return cell
    }
}
