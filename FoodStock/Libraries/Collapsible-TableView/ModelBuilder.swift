//
//  ModelBuilder.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit

class TableSection: SectionItemProtocol {
    
    var title: String
    var uuid: String
    var isVisible: Bool
    var items: [FoodDetail]
    
    init() {
        title = ""
        uuid = ""
        isVisible = false
        items = []
    }
}

class ModelBuilder: NSObject {
    
    class func modelGenerator(stockInfo: [NSDictionary]) -> [SectionItemProtocol] {
        
        var collector = [SectionItemProtocol]()
        
        for item in stockInfo {
            
            let section = TableSection()
            section.title = item[Constants.stockType] as! String
            section.uuid = item[Constants.uuid] as! String
            
            if let items = item[Constants.foodDetail] as? [[String: String]] {
                for foodItem in items {
                    
                    let food = FoodDetail(info: foodItem)
                    section.items.append(food)
                }
             }
            
             collector.append(section)
         }
        
        return collector
    }
}
