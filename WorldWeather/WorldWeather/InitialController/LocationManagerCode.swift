//
//  LocationManagerCode.swift
//  WorldWeather
//
//  Created by Jiaying Xie on 4/9/22.
//

import Foundation
import CoreLocation

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in getting location \(error.localizedDescription)")
//        print("test")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let lat = location.coordinate.latitude
        let lng = location.coordinate.longitude
        print(lat)
        print(lng)
        
        let url = locationAPIURL
        getLocationData(url)
            .done { location in
//                print("in locationManager didUpdateLocations")
//                print(location.key)
//                print(location.city)
//                print(location.state)
//                print(location.country)
                
                getCurrentWeather(currentWeatherURL).done { currentWeatherModel in
//                    print("after calling getCurrentWeather ")
//                    print(currentWeatherModel.WeatherText)
//                    print(currentWeatherModel.WeatherIcon)
//                    print(currentWeatherModel.IsDayTime)
//                    print(currentWeatherModel.Temperature)
                }
                .catch { error in
                    print(error.localizedDescription)
                }
                
            }
            .catch { error in
                print(error.localizedDescription)
            }
    }
}
