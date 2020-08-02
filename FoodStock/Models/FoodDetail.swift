//
//  FoodDetail.swift
//  FoodStock
//
//  Created by Talent on 16.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import Foundation
import UIKit

class FoodDetail {
    
    var stocktype: String
    var foodname: String
    var quantity: String
    var goalquantity: String
    var unit: String
    var expirydate: String
    var expirymonth: String
    var expiryyear: String
    
    init(stocktype: String, foodname: String, quantity: String, goalquantity: String, unit: String, expirydate: String, expirymonth: String, expiryyear: String) {
        self.stocktype = stocktype
        self.foodname = foodname
        self.quantity = quantity
        self.goalquantity = goalquantity
        self.unit = unit
        self.expirydate = expirydate
        self.expirymonth = expirymonth
        self.expiryyear = expiryyear
    }
    
    convenience init(info: [String: String]) {
        
        self.init(stocktype: info[Constants.stockType]!, foodname: info[Constants.foodname]!, quantity: info[Constants.quantity]!, goalquantity: info[Constants.goalquantity]!, unit: info[Constants.unit]!, expirydate: info[Constants.expirydate]!, expirymonth: info[Constants.expirymonth]!, expiryyear: info[Constants.expiryyear]!)
    }
    
}
