//
//  ViewController.swift
//  PromisesExample
//
//  Created by Jiaying Xie on 3/26/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

class ViewController: UIViewController {
    let urlShortQuote = "https://financialmodelingprep.com/api/v3/quote-short/FB?apikey="
    let apiKey = "c3df64605ea6fde8544523c7b2f90016"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getDataAction(_ sender: Any) {
        let url = urlShortQuote + apiKey
        print(url)
        getStockData(url)
            .done { quote in
                print(quote.price)
                print(quote.volume)
                print(quote.symbol)
            }
            .catch { error in
                print(error.localizedDescription)
            }
        
        print("I am here")
    }
    
    // _ url的话，如果调用这个函数，写的是getStockData("asdasfaf").如果不加_的话，调用这个函数写的是getStockData(url: "asdasfaf")
    func getStockData(_ url: String) -> Promise<QuoteShort>{
        // "seal -> Void in" closure, format
        return Promise<QuoteShort> { seal -> Void in
            AF.request(url).responseJSON { response in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                
                // If I am here then I have got the data
                let stocks = JSON(response.data!).array
                if (stocks == nil) {
                    return
                }
                guard let stock = stocks!.first else { return}

                let quote = QuoteShort()
                quote.symbol = stock["symbol"].stringValue
                quote.price = stock["price"].floatValue
                quote.volume = stock["volume"].intValue
                
                print(quote)
                seal.fulfill(quote)
                
            } // end of response
        } // end of promise
    } // end of func
    
}

