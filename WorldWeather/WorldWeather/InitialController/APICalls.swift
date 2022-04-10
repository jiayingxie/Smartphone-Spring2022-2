//
//  APICalls.swift
//  WorldWeather
//
//  Created by Jiaying Xie on 4/3/22.
//

import Foundation
import SwiftyJSON
import Alamofire
import SwiftSpinner
import PromiseKit

extension ViewController{
    func getLocationData(_ url : String) -> Promise<LocationModel>{
        
        return Promise<LocationModel> { seal -> Void in
            AF.request(url).responseJSON { response in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                let location = LocationModel()
                // I will get data here
                print(response.value)
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    let locationJSON = JSON.init(parseJSON: utf8Text)
                    print("weather data")
                    print(locationJSON)
                    location.key = locationJSON["Key"].stringValue
                    location.city = locationJSON["EnglishName"].stringValue
                    location.state = locationJSON["AdministrativeArea"]["ID"].stringValue
                    location.country = locationJSON["Country"]["ID"].stringValue
                }
                seal.fulfill(location) // I am fulfilling the promise
            }// end of response
        }// end is return Promise
        
    }// end of function
    
//    func getCurrentWeather(_ url : String) -> Promise<CurrentWeatherModel>{
//        
//        return Promise<CurrentWeatherModel> { seal -> Void in
//            AF.request(url).responseJSON { response in
//                if response.error != nil {
//                    seal.reject(response.error!)
//                }
//                let currentWeatherModel = CurrentWeatherModel()
//                // I will get data here
//                print(response.value)
////                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
////                    let locationJSON = JSON.init(parseJSON: utf8Text)
////                    print("weather data")
////                    print(locationJSON)
////                    currentWeatherModel.key = locationJSON["Key"].stringValue
////                    currentWeatherModel.city = locationJSON["EnglishName"].stringValue
////                    currentWeatherModel.state = locationJSON["AdministrativeArea"]["ID"].stringValue
////                    currentWeatherModel.country = locationJSON["Country"]["ID"].stringValue
////                }
//                let currentWeatherArray = JSON(response.data).arrayValue
//                guard let currentWeather = currentWeatherArray.first else {return seal.fulfill(currentWeatherModel)}
//                currentWeatherModel.WeatherText = currentWeather["WeatherText"].stringValue
//                currentWeatherModel.WeatherIcon = currentWeather["WeatherIcon"].intValue
//                currentWeatherModel.IsDayTime = currentWeather["IsDayTime"].boolValue
//                currentWeatherModel.Temperature = currentWeather["Temperature"]["Imperial"]["Value"].intValue
//                seal.fulfill(currentWeatherModel) // I am fulfilling the promise
//            }// end of response
//        }// end is return Promise
//        
//    }// end of function
    
}
