//
//  ScanController.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit

class ScanController: BaseViewController {
    
    @IBOutlet weak var ssss: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Scan"
    }
    

    @IBAction func sssssss(_ sender: Any) {
        ssss.text = "hello world"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
