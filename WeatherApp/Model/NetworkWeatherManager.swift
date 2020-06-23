//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Valera on 6/20/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=ru"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric&lang=ru"
        }
        performRequest(withURLString: urlString)
    }
    
    private func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {  data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> CurrentWeather? {
        
        let decoder = JSONDecoder()
        do {
            let currebtWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeathere = CurrentWeather(currentWeatherData: currebtWeatherData) else {
                return nil
            }
            return currentWeathere
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
