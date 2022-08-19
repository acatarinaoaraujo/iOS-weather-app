//
//  WeatherModel.swift
//  Weather-App
//
//  Created by Ana Araujo on 7/17/22.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let countryName: String
    let population: Int

    let lat: Float
    let lon: Float
    
    let weekDays: [String]
    let dates: [String]
    
    let idImage: [String]
    let temp: [String]
    let description: [String]
    let feels: [String]
    
}
