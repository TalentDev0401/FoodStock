//
//  SharingManager.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import Foundation
import UIKit

class SharingManager { //Foodstock2020@gmail.com
    
    static let sharedInstance = SharingManager()
    
    let menuTitles = ["Food Stock", "Spending", "Settings", "Privacy and Policy"]//, "Scan", "Inventory"
    
    var selectindex = 0
    var colors: [UIColor] = [UIColor.yellow, UIColor.orange, UIColor.blue, UIColor.green, UIColor.brown, UIColor(hexString: "#60FFE3"), UIColor(hexString: "#AA0000"), UIColor(hexString: "#AA0477"), UIColor(hexString: "#6900AA"), UIColor(hexString: "#A956AA"), UIColor(hexString: "#FF8AD8"), UIColor(hexString: "#8EAA55"), UIColor.purple, UIColor.systemIndigo, UIColor.systemPink, UIColor.systemTeal, UIColor.lightGray, UIColor.link, UIColor(hexString: "#730099"), UIColor(hexString: "#99cc00"), UIColor(hexString: "#ff33cc"), UIColor(hexString: "#bb99ff"), UIColor(hexString: "#00cc00"), UIColor(hexString: "#00cccc"), UIColor(hexString: "#003300"), UIColor(hexString: "#331a00"), UIColor(hexString: "#b3b300"), UIColor(hexString: "#263300"), UIColor(hexString: "#330026"), UIColor(hexString: "#00aaff"), UIColor(hexString: "#002233"), UIColor(hexString: "#b36b00"), UIColor(hexString: "#003333"), UIColor(hexString: "#260033"), UIColor(hexString: "#ff8c1a"), UIColor(hexString: "#333300"), UIColor(hexString: "#7575a3"), UIColor(hexString: "#c3c388"), UIColor(hexString: "#8000ff"), UIColor(hexString: "#9966ff"), UIColor(hexString: "#13001a"), UIColor(hexString: "#2a0080"), UIColor(hexString: "#993333"), UIColor(hexString: "#29293d"), UIColor(hexString: "#001a00"), UIColor(hexString: "#4d2e00"), UIColor(hexString: "#ff66d9"), UIColor(hexString: "#110033"), UIColor(hexString: "#33331a"), UIColor(hexString: "#1a0033"), UIColor(hexString: "#260d0d"), UIColor(hexString: "#b30059"), UIColor(hexString: "#b30086"), UIColor(hexString: "#cc0066"), UIColor(hexString: "#330026"), UIColor(hexString: "#4d3d00"), UIColor(hexString: "#4d0026"), UIColor(hexString: "#33001a"), UIColor(hexString: "#00e6e6"), UIColor(hexString: "#e6b800")]
}
