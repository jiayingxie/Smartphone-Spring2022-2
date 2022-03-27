//
//  StockViewController.swift
//  StockMaster
//
//  Created by Jiaying Xie on 3/26/22.
//

import UIKit
import RealmSwift

class StockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 为了查看realm database的路径，等console print路径后，复制路径，打开mongodb realm studio，点“open realm file”，然后按command+shift+g，把复制的路径粘贴到输入框里面，enter
        print(Realm.Configuration.defaultConfiguration.fileURL?.path)
        
        loadStockValues()
    }
    

    @IBAction func addDBAction(_ sender: Any) {
        let stock = StockShort()
        stock.symbol = "AAPL"
        stock.price = 120.96
        stock.volume = 332607163

        do{
            // initialize the Reaklm database
           let realm = try Realm()
            // 尝试往database里写入数据
           try realm.write({
               realm.add(stock, update: .modified)
           })
        }catch{
           print("Error in writing to db")
        }
    }
    
    // 查看realm database里的内容
    func loadStockValues(){
        do{
            // initialize the Reaklm database
            let realm = try Realm()
            let stocks = realm.objects(StockShort.self)
          
            for stock in stocks {
                print(stock.symbol)
            }
        }catch{
            print("Error in reading from Realm")
        }
    }
    
    
    func deleteStockFromDB( stock : StockShort){
        do {
            let realm = try Realm()
            try realm.write({
                realm.delete(stock)
            })
            
        }catch{
            print("Unable to delete from Realm DB")
        }
    }
    
    // 获取tsla股票对象
    func getTslaStock() -> StockShort{
        do{
            let realm = try Realm()
            let stocks = realm.objects(StockShort.self)
            
            print(stocks)
            
            for stock in stocks {
                print(stock.symbol)
                if stock.symbol == "TSLA"{
                    return stock
                }
            }
        }catch{
            print("Error in reading from Realm")
        }
        
        return StockShort()
    }
    
    // 注意如果要测试这个功能的话，数据库里要存在symbol是“TSLA”的数据才行，大小写敏感
    @IBAction func deleteTSLAStock(_ sender: Any) {
        // 要先获取tsla在数据库的对象，才能delete它
        let tsla = getTslaStock()
        deleteStockFromDB(stock: tsla)
    }
    
    // 往数据库写入stock
    func addStockToDB(symbol : String){
        let stock = StockShort()
        stock.symbol = symbol
        do{
            let realm = try Realm()
            try realm.write({
                realm.add(stock, update: .modified)
            })
        }catch{
            print("Error in writing to db")
        }
    }
    
    
    @IBAction func addStocksAction(_ sender: Any) {
        var txtField : UITextField?
        
        // 这些是在AlertControllerExample学过的
        let alertController = UIAlertController(title: "Add Stock", message: "", preferredStyle: .alert)
     
        let OKButton = UIAlertAction(title: "OK", style: .default) { action in
            guard let symbol = txtField?.text else {
                return
            }
                    
            self.addStockToDB(symbol: symbol)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        alertController.addAction(OKButton)
        alertController.addAction(cancelButton)
        
        alertController.addTextField { stockTextField in
            stockTextField.placeholder = "Type Stock Symbol"
            txtField = stockTextField
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}
