//
//  StockViewNetworkFunctions.swift
//  StockMasterSecondExample
//
//  Created by Jiaying Xie on 3/26/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit
import SwiftSpinner
extension StockViewController {
    func getAllStockValues(_ symbols: [String]) -> Promise<[QuoteShort]> {
        var promises : [Promise<QuoteShort>] = []
        
        for i in 0 ... symbols.count - 1 {
            promises.append(getStockData(symbols[i]))
        }
        
        return when(fulfilled: promises)
    }
    
    func getStockData(_ symbol : String) -> Promise<QuoteShort>{
        return Promise<QuoteShort> { seal -> Void in
            let url = urlShortQuote + symbol + "?apikey=" + apiKey
            
            sleep(2)
            AF.request(url).responseJSON { response in
                if response.error != nil {
                    seal.reject(response.error!)
                    return
                }
                
                let stocks = JSON(response.data!).array
                let quote = QuoteShort()
                
                if stocks == nil {
                    seal.fulfill(quote)
                    return
                }
                
                guard let firstStock = stocks!.first else {
                    seal.fulfill(quote)
                    return
                }
                
                quote.price = firstStock["price"].floatValue
                quote.volume = firstStock["volume"].intValue
                quote.symbol = firstStock["symbol"].stringValue
                
                seal.fulfill(quote)
            }// end of responseJSON
        } // end of promise
    } // end of func
    
}
