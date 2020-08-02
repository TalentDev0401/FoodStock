//
//  FoodStockCell.swift
//  FoodStock
//
//  Created by Talent on 14.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import SwipeCellKit

class FoodStockCell: SwipeTableViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var expiryextxt: UILabel!
    @IBOutlet weak var expiryDate: UILabel!
    @IBOutlet weak var divide: UILabel!
    @IBOutlet weak var unit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expiryextxt.text = "Expiry : ".localiz()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
