//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Valera on 6/20/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    let feelsLikeTemperature: Double
    
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature)
    }
    
    let minTemperature: Double
    
    var minTemperatureString: String {
        return String(format: "%.0f", minTemperature)
    }
    
    let maxTemperature: Double
    
    var maxTemperatureString: String {
        return String(format: "%.0f", maxTemperature)
    }
    
    let speedWind: Double
    
    var speedWindString: String {
        return String(format: "%.0f", speedWind)
    }
 
    let pressure: Double
    
    var pressureString: String {
        return String(format: "%.0f", pressure)
    }
    
    let humidity: Double
    
    var humidityString: String {
        return String(format: "%.0f", humidity)
    }
    
    let conditionCode: Int
    
    var iconNameString: String {
        switch conditionCode {
        case 200...232:
            return "thunderstorm"
        case 300...321:
            return "drizzle rain"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "fog"
        case 800:
            return "clear sky"
        case 801...804:
            return "cloud"
            
        default:
            return "nosign"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        minTemperature = currentWeatherData.main.tempMin
        maxTemperature = currentWeatherData.main.tempMax
        speedWind = currentWeatherData.wind.speed
        conditionCode = currentWeatherData.weather.first!.id
        pressure = currentWeatherData.main.pressure * 0.75006375541921
        humidity = currentWeatherData.main.humidity
    }
}
