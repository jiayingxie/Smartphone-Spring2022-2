//
//  StockViewController.swift
//  StockMasterSecondExample
//
//  Created by Jiaying Xie on 3/26/22.
//

import UIKit

class StockViewController: UIViewController {
    let stockArr = ["FB", "MSFT", "GOOG", "AMZN"]
    var stockData: [QuoteShort] = []
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadStockData()
    }
    


}
