//
//  CurrentWeatherModel.swift
//  WorldWeather
//
//  Created by Jiaying Xie on 4/9/22.
//

import Foundation

class CurrentWeatherModel{
    init(_ city : String, _ cityKey : String){
        self.city = city
        self.cityKey = cityKey
    }
    var WeatherText = ""
    var WeatherIcon = -1
    var IsDayTime = true
    var Temperature = -1
    var city = ""
    var cityKey = ""
}
