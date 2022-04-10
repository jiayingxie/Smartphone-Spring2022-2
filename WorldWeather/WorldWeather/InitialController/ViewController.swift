//
//  ViewController.swift
//  WorldWeather
//
//  Created by Jiaying Xie on 4/3/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, SendWeatherDelegate {
    
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblWeatherForecast: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblCity: UILabel!
    //    let cities = ["Current Location", "Seattle", "Portland", "London", "Delhi", "Shanghai"]
    let locationManager = CLLocationManager()
    var citiesModel: [CurrentWeatherModel]?
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        citiesModel = initializeCities()
        // get current location and the weather of current location
//        locationManager.requestLocation()
        
    }

//    @IBAction func getLocationData(_ sender: Any) {
//        locationManager.requestLocation()
//    }
    
    func initializeCities() -> [CurrentWeatherModel]{
        let currentLocation = CurrentWeatherModel("Seattle", "2628285");
        
        let seattle = CurrentWeatherModel("Seattle", "2628285");
        let portland = CurrentWeatherModel("Portland", "2627656");
        let london = CurrentWeatherModel("London", "2532799");
        let delhi = CurrentWeatherModel("Delhi", "3588318");
        let shanghai = CurrentWeatherModel("Shanghai", "74833");

        var modelArr = [CurrentWeatherModel]()
        
        modelArr.append(currentLocation)
        modelArr.append(seattle)
        modelArr.append(portland)
        modelArr.append(london)
        modelArr.append(delhi)
        modelArr.append(shanghai)

        return modelArr
    }
    
    func sendWeatherData(_ currentWeatherModel: CurrentWeatherModel) {
        lblCity.text = currentWeatherModel.city
        lblWeatherForecast.text = currentWeatherModel.WeatherText
        lblTemperature.text = "\(currentWeatherModel.Temperature) ℉"
        imgIcon.image = UIImage(named: "\(currentWeatherModel.WeatherIcon)-s")
    }
    
}

