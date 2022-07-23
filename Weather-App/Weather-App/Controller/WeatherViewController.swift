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
    
    @IBOutlet weak var day1Label: UILabel!
    @IBOutlet weak var first5DayStack: UIStackView!
    @IBOutlet weak var first8HoursStack: UIStackView!
    @IBOutlet weak var firstStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var sec5DayStack: UIStackView!
    @IBOutlet weak var sec8HoursStack: UIStackView!
    @IBOutlet weak var secStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var thr5DayStack: UIStackView!
    @IBOutlet weak var thr8HoursStack: UIStackView!
    @IBOutlet weak var thrStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var day4Label: UILabel!
    @IBOutlet weak var four5DayStack: UIStackView!
    @IBOutlet weak var four8HoursStack: UIStackView!
    @IBOutlet weak var fourStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var secSwitch: UISwitch!
    @IBOutlet weak var thirdSwitch: UISwitch!
    @IBOutlet weak var fourSwitch: UISwitch!
    
    @IBOutlet weak var day1Description1: UILabel!
    @IBOutlet weak var day1Description2: UILabel!
    @IBOutlet weak var day1Description3: UILabel!
    @IBOutlet weak var day1Description4: UILabel!
    
    @IBOutlet weak var day2Description1: UILabel!
    @IBOutlet weak var day2Description2: UILabel!
    @IBOutlet weak var day2Description3: UILabel!
    @IBOutlet weak var day2Description4: UILabel!
    
    @IBOutlet weak var day3Description1: UILabel!
    @IBOutlet weak var day3Description2: UILabel!
    @IBOutlet weak var day3Description3: UILabel!
    @IBOutlet weak var day3Description4: UILabel!
    
    @IBOutlet weak var day4Description1: UILabel!
    @IBOutlet weak var day4Description2: UILabel!
    @IBOutlet weak var day4Description3: UILabel!
    @IBOutlet weak var day4Description4: UILabel!
    
    
    @IBOutlet weak var idDay1Hr1Image: UIImageView!
    @IBOutlet weak var idDay1Hr2Image: UIImageView!
    @IBOutlet weak var idDay1Hr3Image: UIImageView!
    @IBOutlet weak var idDay1Hr4Image: UIImageView!
    
    @IBOutlet weak var idDay2Hr1Image: UIImageView!
    @IBOutlet weak var idDay2Hr2Image: UIImageView!
    @IBOutlet weak var idDay2Hr3Image: UIImageView!
    @IBOutlet weak var idDay2Hr4Image: UIImageView!
    
    @IBOutlet weak var idDay3Hr1Image: UIImageView!
    @IBOutlet weak var idDay3Hr2Image: UIImageView!
    @IBOutlet weak var idDay3Hr3Image: UIImageView!
    @IBOutlet weak var idDay3Hr4Image: UIImageView!
    
    @IBOutlet weak var idDay4Hr1Image: UIImageView!
    @IBOutlet weak var idDay4Hr2Image: UIImageView!
    @IBOutlet weak var idDay4Hr3Image: UIImageView!
    @IBOutlet weak var idDay4Hr4Image: UIImageView!
    
    @IBOutlet weak var tempDay1Hr1: UILabel!
    @IBOutlet weak var tempDay1Hr2: UILabel!
    @IBOutlet weak var tempDay1Hr3: UILabel!
    @IBOutlet weak var tempDay1Hr4: UILabel!
    
    @IBOutlet weak var tempDay2Hr1: UILabel!
    @IBOutlet weak var tempDay2Hr2: UILabel!
    @IBOutlet weak var tempDay2Hr3: UILabel!
    @IBOutlet weak var tempDay2Hr4: UILabel!
    
    @IBOutlet weak var tempDay3Hr1: UILabel!
    @IBOutlet weak var tempDay3Hr2: UILabel!
    @IBOutlet weak var tempDay3Hr3: UILabel!
    @IBOutlet weak var tempDay3Hr4: UILabel!
    
    @IBOutlet weak var tempDay4Hr1: UILabel!
    @IBOutlet weak var tempDay4Hr2: UILabel!
    @IBOutlet weak var tempDay4Hr3: UILabel!
    @IBOutlet weak var tempDay4Hr4: UILabel!
    
    @IBOutlet weak var feelsDay1Hr1: UILabel!
    @IBOutlet weak var feelsDay1Hr2: UILabel!
    @IBOutlet weak var feelsDay1Hr3: UILabel!
    @IBOutlet weak var feelsDay1Hr4: UILabel!
    
    @IBOutlet weak var feelsDay2Hr1: UILabel!
    @IBOutlet weak var feelsDay2Hr2: UILabel!
    @IBOutlet weak var feelsDay2Hr3: UILabel!
    @IBOutlet weak var feelsDay2Hr4: UILabel!
    
    @IBOutlet weak var feelsDay3Hr1: UILabel!
    @IBOutlet weak var feelsDay3Hr2: UILabel!
    @IBOutlet weak var feelsDay3Hr3: UILabel!
    @IBOutlet weak var feelsDay3Hr4: UILabel!
    
    @IBOutlet weak var feelsDay4Hr1: UILabel!
    @IBOutlet weak var feelsDay4Hr2: UILabel!
    @IBOutlet weak var feelsDay4Hr3: UILabel!
    @IBOutlet weak var feelsDay4Hr4: UILabel!
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var allStacksHeight: NSLayoutConstraint!
    
    
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
        
        initialSetUp()
        
    }
    
    func initialSetUp () {
        
        scrollView.isHidden = true
        cityLabel.isHidden = true
        populationLabel.isHidden = true
        coordLabel.isHidden = true
        
        first8HoursStack.isHidden = true
        firstStackHeight.constant = 36
        
        sec8HoursStack.isHidden = true
        secStackHeight.constant = 36
        
        thr8HoursStack.isHidden = true
        thrStackHeight.constant = 36
        
        four8HoursStack.isHidden = true
        fourStackHeight.constant = 36
        
        allStacksHeight.constant = 180
    }
    
    @IBAction func switchedMoved(_ sender: UISwitch) {

        modifyStacks(firstSwitch.isOn, first8HoursStack, firstStackHeight)
        modifyStacks(secSwitch.isOn, sec8HoursStack, secStackHeight)
        modifyStacks(thirdSwitch.isOn, thr8HoursStack, thrStackHeight)
        modifyStacks(fourSwitch.isOn, four8HoursStack, fourStackHeight)
    
    }
    
    
    func modifyStacks(_ state: Bool, _ stack: UIStackView, _ height: NSLayoutConstraint) {
        
        var counterHeigh = 180
        
        if state {
            stack.isHidden = false
            height.constant = 336
            counterHeigh += 330
        } else {
            stack.isHidden = true
            height.constant = 36
            counterHeigh -= 330
        }
        
        allStacksHeight.constant = CGFloat(counterHeigh)
        
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
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            self.scrollView.isHidden = false
            self.cityLabel.isHidden = false
            self.populationLabel.isHidden = false
            self.coordLabel.isHidden = false
            
            self.cityLabel.text = weather.cityName + ", " + weather.countryName
            self.populationLabel.text = "Population: " + (numberFormatter.string(from: NSNumber(value:weather.population)) ?? "0.0")
            self.coordLabel.text = "Coordinates: [" + String(weather.lat) + "," + String(weather.lon) + "]"
            
            self.day1Label.text = weather.weekDays[0] + " " + weather.dates[0].suffix(5)
            self.day2Label.text = weather.weekDays[1] + " " + weather.dates[1].suffix(5)
            self.day3Label.text = weather.weekDays[2] + " " + weather.dates[2].suffix(5)
            self.day4Label.text = weather.weekDays[3] + " " + weather.dates[3].suffix(5)
            
            self.day1Description1.text = weather.description[4]
            self.day1Description2.text = weather.description[5]
            self.day1Description3.text = weather.description[6]
            self.day1Description4.text = weather.description[7]
            
            self.day2Description1.text = weather.description[12]
            self.day2Description2.text = weather.description[13]
            self.day2Description3.text = weather.description[14]
            self.day2Description4.text = weather.description[15]
            
            self.day3Description1.text = weather.description[20]
            self.day3Description2.text = weather.description[21]
            self.day3Description3.text = weather.description[22]
            self.day3Description4.text = weather.description[23]
            
            self.day4Description1.text = weather.description[28]
            self.day4Description2.text = weather.description[29]
            self.day4Description3.text = weather.description[30]
            self.day4Description4.text = weather.description[31]
            
            self.tempDay1Hr1.text = weather.temp[4] + "°F"
            self.tempDay1Hr2.text = weather.temp[5] + "°F"
            self.tempDay1Hr3.text = weather.temp[6] + "°F"
            self.tempDay1Hr4.text = weather.temp[7] + "°F"
            
            self.tempDay2Hr1.text = weather.temp[12] + "°F"
            self.tempDay2Hr2.text = weather.temp[13] + "°F"
            self.tempDay2Hr3.text = weather.temp[14] + "°F"
            self.tempDay2Hr4.text = weather.temp[15] + "°F"
            
            self.tempDay3Hr1.text = weather.temp[20] + "°F"
            self.tempDay3Hr2.text = weather.temp[21] + "°F"
            self.tempDay3Hr3.text = weather.temp[22] + "°F"
            self.tempDay3Hr4.text = weather.temp[23] + "°F"
            
            self.tempDay4Hr1.text = weather.temp[28] + "°F"
            self.tempDay4Hr2.text = weather.temp[29] + "°F"
            self.tempDay4Hr3.text = weather.temp[30] + "°F"
            self.tempDay4Hr4.text = weather.temp[31] + "°F"
            
            self.feelsDay1Hr1.text = "feels like: " + weather.feels[4] + "°"
            self.feelsDay1Hr2.text = "feels like: " + weather.feels[5] + "°"
            self.feelsDay1Hr3.text = "feels like: " + weather.feels[6] + "°"
            self.feelsDay1Hr4.text = "feels like: " + weather.feels[7] + "°"
            
            self.feelsDay2Hr1.text = "feels like: " + weather.feels[12] + "°"
            self.feelsDay2Hr2.text = "feels like: " + weather.feels[13] + "°"
            self.feelsDay2Hr3.text = "feels like: " + weather.feels[14] + "°"
            self.feelsDay2Hr4.text = "feels like: " + weather.feels[15] + "°"
            
            self.feelsDay3Hr1.text = "feels like: " + weather.feels[20] + "°"
            self.feelsDay3Hr2.text = "feels like: " + weather.feels[21] + "°"
            self.feelsDay3Hr3.text = "feels like: " + weather.feels[22] + "°"
            self.feelsDay3Hr4.text = "feels like: " + weather.feels[23] + "°"
            
            self.feelsDay4Hr1.text = "feels like: " + weather.feels[28] + "°"
            self.feelsDay4Hr2.text = "feels like: " + weather.feels[29] + "°"
            self.feelsDay4Hr3.text = "feels like: " + weather.feels[30] + "°"
            self.feelsDay4Hr4.text = "feels like: " + weather.feels[31] + "°"
            
        
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
