//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Valera on 6/20/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation

struct CurrentWeatherData: Codable {
    
    let name: String
    let main: Main
    let wind: Wind
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double 
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Codable {
    let speed: Double
}

struct Weather: Codable {
    let id: Int
}
