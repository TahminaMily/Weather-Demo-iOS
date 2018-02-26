//
//  ForecastViewController.swift
//  Weather
//
//  Created by Tahmina Khanam on 25/2/18.
//

import UIKit

class ForecastViewController: UIViewController {
    enum Section {
        case current, hourly, daily, summary
        
        var identifier: String {
            switch self {
            case .current: return CurrentWeatherCell.reuseIdentifier
            case .hourly: return HourlyWeatherCell.reuseIdentifier
            case .daily: return DailyWeatherCell.reuseIdentifier
            case .summary: return SummaryCell.reuseIdentifier
            }
        }
        
    }
    let sections: [Section] = [.current, .hourly, .daily, .summary]
    var forecast: Weather.Forecast? = nil
    
    @IBOutlet var tableView: UITableView!
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        
        let service = Webservice()
        spinner.startAnimating()
        service.load(url: Weather.webserviceURL) { [weak self] (result: Result<Weather.Forecast, Webservice.Error>) in
            guard let this = self else { return }
            DispatchQueue.main.async {
                this.spinner.stopAnimating()
                switch result {
                case .success(let response):
                    this.forecast = response
                    this.tableView.reloadData()
                case .failure(let error):
                    this.alert(message: error.localizedDescription)
                }
            }
        }
    }
}

extension ForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .current:
            return forecast?.currently.flatMap { _ in 1 } ?? 0
        case .hourly:
            return forecast?.hourly.flatMap { _ in 1 } ?? 0
        case .daily:
            return forecast?.daily?.data.count ?? 0
        case .summary:
            return forecast?.daily?.data.first.flatMap { _ in 1 } ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: section.identifier, for: indexPath)
        
        // not really happy with the following code, reeks of code smell.
        // If had enough time, may be its possible to reduce it using generics and POP
        switch section {
        case .current:
            guard
                let cell = tableViewCell as? CurrentWeatherCell,
                let viewModel = CurrentWeatherCell.ViewModel(forecast?.currently)
            else { return tableViewCell }
            
            cell.bind(viewModel)
        case .hourly:
            guard
                let cell = tableViewCell as? HourlyWeatherCell,
                let viewModel = HourlyWeatherCell.ViewModel(forecast?.hourly)
            else { return tableViewCell }
            
            cell.bind(viewModel)
        case .daily:
            guard
                let cell = tableViewCell as? DailyWeatherCell,
                let viewModel = DailyWeatherCell.ViewModel(forecast?.daily?.data[indexPath.row])
            else { return tableViewCell }
            
            cell.bind(viewModel)
        case .summary:
            guard
                let cell = tableViewCell as? SummaryCell,
                let viewModel  = SummaryCell.ViewModel(forecast?.daily?.data.first)
            else { return tableViewCell }
            
            cell.bind(viewModel)
        }
        return tableViewCell
    }
}

