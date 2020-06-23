//
//  ViewController.swift
//  WeatherApp
//
//  Created by Valera on 6/17/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet var weatherIconImage: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var temperatureMin: UILabel!
    @IBOutlet var temperatureMax: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.onCompletion = { [weak self ] currentWeather in
            guard let self = self else { return }
            self.updateIntarfaceWith(weather: currentWeather)
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }

    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
    self.presentSearchAlertController(withTitle: "Enter city name",
                                          message: nil,
                                          style: .alert) { [unowned self ] city in
                                            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
    
    func updateIntarfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeLabel.text = weather.feelsLikeTemperatureString + " °C"
            self.temperatureMin.text = weather.minTemperatureString + " °C"
            self.temperatureMax.text = weather.maxTemperatureString + " °C"
            self.windSpeed.text = weather.speedWindString + " m/s"
            self.humidityLabel.text = weather.humidityString + " %"
            self.pressureLabel.text = weather.pressureString + " mm"
            self.weatherIconImage.image = UIImage(named: weather.iconNameString)
        }
    }
}

//MARK: CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}


