//
//  StockShort.swift
//  StockMaster
//
//  Created by Jiaying Xie on 3/26/22.
//

import Foundation
import RealmSwift

class StockShort : Object{
    @objc dynamic var symbol : String = ""
    @objc dynamic var price : Float = 0.0
    @objc dynamic var volume : Int = 0
    
    override static func primaryKey() -> String? {
        return "symbol"
    }
}

