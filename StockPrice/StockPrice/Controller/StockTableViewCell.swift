//
//  StockTableViewCell.swift
//  StockPrice
//
//  Created by Jiaying Xie on 4/10/22.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    
    var symbol = ""
    var sendStockDelegate : SendStockDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func getStockPriceAction(_ sender: Any) {
        let currentURL = getStockURL(symbol)
        print(currentURL)
        
        getStockPrice(currentURL).done { stockQuote in
            stockQuote.symbol = self.symbol
            self.sendStockDelegate?.sendWeatherData(stockQuote)
        }
        .catch { error in
            print("in getStockPriceAction \(error.localizedDescription)")
        }
    }
    
}
