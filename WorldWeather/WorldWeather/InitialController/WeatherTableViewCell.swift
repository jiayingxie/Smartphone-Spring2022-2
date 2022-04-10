//
//  WeatherTableViewCell.swift
//  WorldWeather
//
//  Created by Jiaying Xie on 4/9/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCity: UILabel!
    
    var cityKey = ""
    var city = ""
    var sendWeatherDelegate : SendWeatherDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func getWeatherAction(_ sender: Any) {
        let currentURL = getCurrentWeatherURL(cityKey)
//        print(currentURL)
        getCurrentWeather(currentURL).done { currentWeatherModel in
            currentWeatherModel.city = self.city
//            print(currentWeatherModel.WeatherText)
//            print(currentWeatherModel.WeatherIcon)
//            print(currentWeatherModel.IsDayTime)
//            print(currentWeatherModel.Temperature)
            self.sendWeatherDelegate?.sendWeatherData(currentWeatherModel)
        }
        .catch { error in
            print(error.localizedDescription)
        }
    }
}
