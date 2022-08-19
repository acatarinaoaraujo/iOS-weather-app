//
//  WeatherData.swift
//  Weather-App
//
//  Created by Ana Araujo on 7/17/22.
//

import Foundation

struct WeatherData: Codable {
    let city: City
    let list: [List]
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


struct List: Codable {
    let main: Main
    let weather: [Weather]
    let dt_txt: String
}

struct Main: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
}

struct Weather: Codable {
    let id: Int
    let description: String
}








