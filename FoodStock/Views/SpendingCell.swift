//
//  SpendingCell.swift
//  FoodStock
//
//  Created by Talent on 15.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import SwipeCellKit

class SpendingCell: SwipeTableViewCell {
    
    @IBOutlet weak var colorview: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
