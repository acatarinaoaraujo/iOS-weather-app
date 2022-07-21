//
//  WeatherData.swift
//  Clima
//
//  Created by Angela Yu on 03/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

/*struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}*/

struct WeatherData: Codable {
    let city: City
}

struct City: Codable {
    let name: String
    let country: String
    let population: Int
    let coord: Coordinates
    
}

struct Coordinates: Codable {
    let lat: Float
    let lon: Float
}






