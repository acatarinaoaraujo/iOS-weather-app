//
//  WeatherModel.swift
//  Clima
//
//  Created by Angela Yu on 03/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
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
