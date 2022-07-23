//
//  WeatherModel.swift
//  Clima
//
//  Created by Angela Yu on 03/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    //let conditionId: Int
    let cityName: String
    let countryName: String
    let population: Int

    let lat: Float
    let lon: Float
    
    let weekDays: [String]
    let dates: [String]
    
    let temp: [String]
    let description: [String]
    let feels: [String]
    
    //let hours: [String]
    /*let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float

    let id: Int
    let description: String*/
    //let temperature: Double
    
    /* Computed Properties: temperatureString & conditionName
       Syntax: var name: return value { return [computation]} */
    /*var temperatureString: String {
        return String(format: "%.1f", temperature)
    }*/
   /*
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
     */
}
