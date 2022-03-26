//
//  StockViewController.swift
//  NailStocksExercise
//
//  Created by Jiaying Xie on 3/25/22.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire

class StockViewController: UIViewController {
    @IBOutlet weak var txtStockSymbol: UITextField!
    
    @IBOutlet weak var lblStock: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func searchForPrice(_ sender: Any) {
        guard let symbol = txtStockSymbol.text else {return }
        
        let url = "\(shortQuoteURL)\(symbol.uppercased())?apikey=\(apiKey)"
        print(url)

        // 这个是用来加载spinner的，就是类似给用户看正在加载中的功能
        SwiftSpinner.show("Getting Stock Value for \(symbol)")
        
        // 不太懂，大概是获取url里的json信息吧
        AF.request(url).responseJSON { response in
            SwiftSpinner.hide(nil)
            if response.error != nil {
                print(response.error!)
                return
            }
            // If I am here then I have got the data
            
            let stocks = JSON(response.data!).array
            
            guard let stock = stocks!.first else { return}
            
            print(stock)
            // 新建一个对象，将查到的股票信息赋值给这个对象
            let quote = QuoteShort()
            quote.symbol = stock["symbol"].stringValue
            quote.price = stock["price"].floatValue
            quote.volume = stock["volume"].intValue

            self.lblStock.text = "\(quote.symbol) : \(quote.price) $"
                        
        }
        
    }
    
    
    
}
