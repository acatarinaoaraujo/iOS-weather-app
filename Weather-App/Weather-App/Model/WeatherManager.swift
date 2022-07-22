//
//  WeatherManager.swift
//  Clima
//
//  Created by Angela Yu on 03/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    //let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c6856320ce2188319591d654c250e2dd&units=metric"
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=c6856320ce2188319591d654c250e2dd&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            /*let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name*/
            
            let name = decodedData.city.name
            let country = decodedData.city.country
            let population = decodedData.city.population
            
            let lat  = decodedData.city.coord.lat
            let lon  = decodedData.city.coord.lon
            
            print(name)
            print(country)
            print(population)
            print(lat)
            print(lon)
            //print(decodedData.self)
            
            let tupleDates = get5DayInfo(0, 33, decodedData)
            let dates = tupleDates.0
            let dayOfWeek = tupleDates.1
        
            
            /*
             let temp = decodedData.list[0..40].main[0].temp
             let feels = decodedData.list[0..40].main[0].feels
             
             let id = decodedData.list[0..40].weather[0].id
             let description = decodedData.list[0..40].weather[0].description
             
             let day = decodedData.list[0..40].dt_txt (first part)
             let time = decodedData.list[0..40].dt_txt (second part)
             
             let maxTempDay = max(decodedData.list[0..8].main[0].temp_max)
             let minTempDay = min(decodedData.list[0..8].main[0].temp_min)
             let dayOfWeek = find day of week
             
             */
            
            //let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            let weather = WeatherModel(cityName: name, countryName: country, population: population, lat: lat, lon: lon, weekDays: dayOfWeek, dates: dates)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func get5DayInfo(_ start: Int, _ end: Int, _ data: WeatherData) -> ([String], [String]) {
        var dayOfWeek: [String] = []
        var dates: [String] = []
        
        for i in stride(from: start, to: end, by: 8) {
            let lower = String.Index(encodedOffset: 0)
            let upper = String.Index(encodedOffset: 10)
            dates.append(String(data.list[i].dt_txt[lower..<upper]))
        }
        
        func getDayOfWeek(_ date:String, format: String) -> String? {
            
            let weekDays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

            let formatter  = DateFormatter()
            formatter.dateFormat = format
            guard let myDate = formatter.date(from: date) else { return nil }
            
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: myDate)
            
            return weekDays[weekDay-1]
        }

        for i in 0...4 {
            if let weekday = getDayOfWeek(dates[i], format:"yyyy-MM-dd") {
                dayOfWeek.append(weekday)
            } else {
                print("Invalid Date")
            }
        }

        return (dates, dayOfWeek)
        
    }
    
    /*func getDayInfo (rangeLow low: Int, rangeHigh high: Int,_ data: WeatherData) -> [String] {
        var dayOfWeek: [String]
        
        dayOfWeek = ["Ana", "Catarina"]
        
        //dayOfWeek.append(data.list[0].dt_txt)
        
        return dayOfWeek
    }*/
    
    
    
}


