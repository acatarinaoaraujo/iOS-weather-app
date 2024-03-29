//
//  WeatherManager.swift
//  Weather-App
//
//  Created by Ana Araujo on 7/17/22.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
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
                    print(safeData)
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
            
            let name = decodedData.city.name
            let country = decodedData.city.country
            let population = decodedData.city.population
            let lat  = decodedData.city.coord.lat
            let lon  = decodedData.city.coord.lon
            
            let tupleDates = get5DayInfo(0, 32, decodedData)
            let dates = tupleDates.0
            let dayOfWeek = tupleDates.1
        
            let description = getWeatherDescription(0, 40, decodedData)
            let temp = getTemperature(0, 40, decodedData)
            let feels = getFeelsLike(0, 40, decodedData)
            let idImage = getImageCode(0, 40, decodedData)
            
            let weather = WeatherModel(cityName: name, countryName: country, population: population, lat: lat, lon: lon, weekDays: dayOfWeek, dates: dates, idImage: idImage, temp: temp, description: description, feels: feels)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func get5DayInfo(_ start: Int, _ end: Int, _ data: WeatherData) -> ([String], [String]) {
        var dayOfWeek: [String] = []
        var dates: [String] = []
        
        for i in stride(from: start, to: end + 1, by: 8) {
            dates.append(String(data.list[i].dt_txt.prefix(10)))
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
    
    func getWeatherDescription(_ start: Int, _ end: Int, _ data: WeatherData) -> [String] {
        var description: [String] = []
        
        for i in start...end - 1 {
            let hourDescription = data.list[i].weather[0].description
            description.append(String(hourDescription))
        }
        
        return description
        
    }
    
    func getTemperature(_ start: Int, _ end: Int, _ data: WeatherData) -> [String] {
        var temperatures: [String] = []
        
        for i in start...end - 1 {
            let hourTemp = data.list[i].main.temp
            temperatures.append(String(format: "%.0f", hourTemp))
        }
        
        return temperatures
        
    }
    
    func getFeelsLike(_ start: Int, _ end: Int, _ data: WeatherData) -> [String] {
        var feels: [String] = []
        
        for i in start...end - 1 {
            let hourFeelsLike = data.list[i].main.feels_like
            feels.append(String(format: "%.0f", hourFeelsLike))
        }
        
        return feels
        
    }
    
    func getImageCode(_ start: Int, _ end: Int, _ data: WeatherData) -> [String] {
        var imageCodes: [String] = []
        
        for i in start...end - 1 {
            let hourImageCode = data.list[i].weather[0].id
            
            var conditionName: String {
                switch hourImageCode {
                case 200...232:
                    return "cloud.bolt.rain.fill"
                case 300...321:
                    return "cloud.drizzle.fill"
                case 500...531:
                    return "cloud.heavyrain.fill"
                case 600...622:
                    return "snowflake"
                case 701...781:
                    return "smoke.fill"
                case 800:
                    return "sun.max"
                case 801...802:
                    return "cloud.sun.fill"
                case 803...804:
                    return "cloud.fog.fill"
                default:
                    return "cloud"
                }
            }
            
            imageCodes.append(String(conditionName))
        }
        return imageCodes
        
    }
    
    
   
    

}


