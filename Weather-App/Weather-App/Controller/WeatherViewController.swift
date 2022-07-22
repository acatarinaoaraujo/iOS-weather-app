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
    @IBOutlet weak var min1DayLabel: UILabel!
    @IBOutlet weak var max1DayLabel: UILabel!
    @IBOutlet weak var first5DayStack: UIStackView!
    @IBOutlet weak var first8HoursStack: UIStackView!
    @IBOutlet weak var firstStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var min2DayLabel: UILabel!
    @IBOutlet weak var max2DayLabel: UILabel!
    @IBOutlet weak var sec5DayStack: UIStackView!
    @IBOutlet weak var sec8HoursStack: UIStackView!
    @IBOutlet weak var secStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var min3DayLabel: UILabel!
    @IBOutlet weak var max3DayLabel: UILabel!
    @IBOutlet weak var thr5DayStack: UIStackView!
    @IBOutlet weak var thr8HoursStack: UIStackView!
    @IBOutlet weak var thrStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var day4Label: UILabel!
    @IBOutlet weak var min4DayLabel: UILabel!
    @IBOutlet weak var max4DayLabel: UILabel!
    @IBOutlet weak var four5DayStack: UIStackView!
    @IBOutlet weak var four8HoursStack: UIStackView!
    @IBOutlet weak var fourStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var day5Label: UILabel!
    @IBOutlet weak var min5DayLabel: UILabel!
    @IBOutlet weak var max5DayLabel: UILabel!
    @IBOutlet weak var five5DayStack: UIStackView!
    @IBOutlet weak var five8HoursStack: UIStackView!
    @IBOutlet weak var fiveStackHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var secSwitch: UISwitch!
    @IBOutlet weak var thirdSwitch: UISwitch!
    @IBOutlet weak var fourSwitch: UISwitch!
    @IBOutlet weak var fivSwitch: UISwitch!
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var allStacksHeight: NSLayoutConstraint!
    
    
   /* @IBOutlet weak var day1Hour1: UILabel!
    @IBOutlet weak var day1Hour2: UILabel!
    @IBOutlet weak var day1Hour3: UILabel!
    @IBOutlet weak var day1Hour4: UILabel!
    @IBOutlet weak var day1Hour5: UILabel!
    @IBOutlet weak var day1Hour6: UILabel!
    @IBOutlet weak var day1Hour7: UILabel!
    @IBOutlet weak var day1Hour8: UILabel!
    
    @IBOutlet weak var day2Hour1: UILabel!
    @IBOutlet weak var day2Hour2: UILabel!
    @IBOutlet weak var day2Hour3: UILabel!
    @IBOutlet weak var day2Hour4: UILabel!
    @IBOutlet weak var day2Hour5: UILabel!
    @IBOutlet weak var day2Hour6: UILabel!
    @IBOutlet weak var day2Hour7: UILabel!
    @IBOutlet weak var day2Hour8: UILabel!
    
    @IBOutlet weak var day3Hour1: UILabel!
    @IBOutlet weak var day3Hour2: UILabel!
    @IBOutlet weak var day3Hour3: UILabel!
    @IBOutlet weak var day3Hour4: UILabel!
    @IBOutlet weak var day3Hour5: UILabel!
    @IBOutlet weak var day3Hour6: UILabel!
    @IBOutlet weak var day3Hour7: UILabel!
    @IBOutlet weak var day3Hour8: UILabel!*/
    
    
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
        
        five8HoursStack.isHidden = true
        fiveStackHeight.constant = 36
        
        allStacksHeight.constant = 180
    }
    
    @IBAction func switchedMoved(_ sender: UISwitch) {

        modifyStacks(firstSwitch.isOn, first8HoursStack, firstStackHeight)
        modifyStacks(secSwitch.isOn, sec8HoursStack, secStackHeight)
        modifyStacks(thirdSwitch.isOn, thr8HoursStack, thrStackHeight)
        modifyStacks(fourSwitch.isOn, four8HoursStack, fourStackHeight)
        modifyStacks(fivSwitch.isOn, five8HoursStack, fiveStackHeight)
    
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
            self.day5Label.text = weather.weekDays[4] + " " + weather.dates[4].suffix(5)
            
           /* self.day1Hour1.text = weather.hours[5]
            self.day1Hour2.text = weather.hours[6]
            self.day1Hour3.text = weather.hours[7]
            self.day1Hour4.text = weather.hours[0]
            self.day1Hour5.text = weather.hours[1]
            self.day1Hour6.text = weather.hours[2]
            self.day1Hour7.text = weather.hours[3]
            self.day1Hour8.text = weather.hours[4]
            
            self.day2Hour1.text = weather.hours[13]
            self.day2Hour2.text = weather.hours[14]
            self.day2Hour3.text = weather.hours[15]
            self.day2Hour4.text = weather.hours[8]
            self.day2Hour5.text = weather.hours[9]
            self.day2Hour6.text = weather.hours[10]
            self.day2Hour7.text = weather.hours[11]
            self.day2Hour8.text = weather.hours[12]
            
            self.day3Hour1.text = weather.hours[21]
            self.day3Hour2.text = weather.hours[22]
            self.day3Hour3.text = weather.hours[23]
            self.day3Hour4.text = weather.hours[16]
            self.day3Hour5.text = weather.hours[17]
            self.day3Hour6.text = weather.hours[18]
            self.day3Hour7.text = weather.hours[19]
            self.day3Hour8.text = weather.hours[20]*/
            
        
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
