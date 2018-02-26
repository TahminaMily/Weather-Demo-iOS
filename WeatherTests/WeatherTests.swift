//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Tahmina Khanam on 25/2/18.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Formatters.time.locale = Locale(identifier: "en_AU")
        Formatters.day.locale = Locale(identifier: "en_AU")
        Formatters.temperature.locale = Locale(identifier: "en_AU")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCurrentWeatherViewModel() {
        let json = """
        {
            "time": 0,
            "temperature": 19.43,
            "apparentTemperature": 19.43
        }
        """
        let data = json.data(using: .utf8)!
        let dataPoint: Weather.DataPoint? = try? JSONDecoder().decode(Weather.DataPoint.self, from: data)
        
        XCTAssertNotNil(dataPoint)
        
        let viewModel = CurrentWeatherCell.ViewModel(dataPoint)
        
        XCTAssertNotNil(viewModel)
        
        XCTAssertEqual(viewModel?.tempreature, "19°C", "Formatted temperature should be whole numbered")
    }
    
    func testTimeFormatter() {
        let date = Date(timeIntervalSince1970: 0)
        let timeString = Formatters.time.string(from: date)
        
        XCTAssertEqual(timeString, "10 am")
    }
    
    func testDayFormatter() {
        let date = Date(timeIntervalSince1970: 0)
        let dayString = Formatters.day.string(from: date)
        
        XCTAssertEqual(dayString, "Thursday")
    }
}
