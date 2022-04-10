//
//  ProtocalSendWeatherData.swift
//  WorldWeather
//
//  Created by Jiaying Xie on 4/9/22.
//

import Foundation

protocol SendWeatherDelegate {
    func sendWeatherData(_ currentWeatherModel : CurrentWeatherModel)
}
