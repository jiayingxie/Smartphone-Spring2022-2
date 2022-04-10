//
//  NetworkFunctions.swift
//  StockPrice
//
//  Created by Jiaying Xie on 4/10/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit
import SwiftSpinner

func getStockURL(_ symbol : String) -> String{
    let url = "\(url)\(symbol)?apikey=\(apiKey)"
    return url
}

func getSymbolListURL() -> String{
    let url = "\(symbolListURL)\(apiKey)"
    return url
}

func getStockPrice(_ url : String) -> Promise<StockQuote>{
    return Promise<StockQuote> { seal -> Void in
        AF.request(url).responseJSON { response in
            
            if response.error != nil {
                seal.reject(response.error!)
            }
            
            let stockQuote = StockQuote("", "")
            //get data here
            let currentStockArray = JSON(response.data!).arrayValue
            guard let currentStock = currentStockArray.first else {return seal.fulfill(stockQuote)}
            
            stockQuote.companyName = currentStock["name"].stringValue
            stockQuote.symbol = currentStock["symbol"].stringValue
            stockQuote.price = currentStock["dayLow"].stringValue
            stockQuote.dayLow = currentStock["dayLow"].stringValue
            stockQuote.dayHigh = currentStock["dayHigh"].stringValue
            
//            print(stockQuote.companyName)
//            print(stockQuote.symbol)
//            print(stockQuote.price)
//            print(stockQuote.dayLow)
//            print(stockQuote.dayHigh)
            
            seal.fulfill(stockQuote)
        }// end of response
    }// end is return Promise
}// end of function





//func getSymbolList(_ url : String) -> Promise<[SymbolModel]>{
//    
//    SwiftSpinner.show("Fetching data...")
//    return Promise<[SymbolModel]> { seal -> Void in
//        
//        var symbolListArray : [SymbolModel] = [SymbolModel]()
//        
//        AF.request(url).responseJSON { response in
//            switch response.result {
//                case .success(let success):
//                    SwiftSpinner.hide()
//                    let symbolsArray = JSON(success)
////                print(symbolsArray)
//                    for (_, symbol): (String, JSON) in symbolsArray {
//                        let symbolModel = SymbolModel()
//                        symbolModel.symbol = symbol["symbol"].stringValue
//                        symbolModel.companyName = symbol["name"].stringValue
////                        print(symbolModel.companyName)
////                        print(symbolModel.symbol)
//                        symbolListArray.append(symbolModel)
//                    }
////                print(symbolListArray
//                    seal.fulfill(symbolListArray)
//
//                case .failure(let error):
//                    SwiftSpinner.show("Failed", animated: false).addTapHandler({
//                        SwiftSpinner.hide()
//                    }, subtitle: "Tap to hide.")
//                    print("Error:\(error)")
//                    seal.reject(error)
//            }
//            
//        } // AF
//    }// end is return Promise
//}
