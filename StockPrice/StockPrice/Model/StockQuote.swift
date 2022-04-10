//
//  StockQuote.swift
//  StockPrice
//
//  Created by Jiaying Xie on 4/10/22.
//

import Foundation

// Company Name, Symbol, Price, Day High and Day low
class StockQuote {
    init(_ symbol : String, _ companyName: String){
        self.symbol = symbol
        self.companyName = companyName
    }
    var companyName = ""
    var symbol = ""
    var price = ""
    var dayHigh = ""
    var dayLow = ""
}
