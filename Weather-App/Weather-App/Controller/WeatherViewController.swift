//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    /*@IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!*/
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var coordLabel: UILabel!
    
    
    @IBOutlet weak var first5DayStack: UIStackView!
    @IBOutlet weak var view8HoursStack: UIStackView!
    
    
    @IBOutlet weak var firstStackHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        view8HoursStack.isHidden = true
        firstStackHeight.constant = 100
    }
    
    @IBAction func switchedMoved(_ sender: UISwitch) {
        print("HELLO")
        
        if sender.isOn {
            view8HoursStack.isHidden = false
            firstStackHeight.constant = 336
        } else {
            view8HoursStack.isHidden = true
            firstStackHeight.constant = 100
        }
        
        // self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + 20.0)
        
    
    }
    
    
    

}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
        
    }
    
}

//MARK: - WeatherManagerDelegate


extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            //self.temperatureLabel.text = weather.temperatureString
            //self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName + ", " + weather.countryName
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            self.populationLabel.text = "Population: " + (numberFormatter.string(from: NSNumber(value:weather.population)) ?? "0.0")
            
            self.coordLabel.text = "Coordinates: [" + String(weather.lat) + "," + String(weather.lon) + "]"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate


extension WeatherViewController: CLLocationManagerDelegate {
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
