//
//  BaseViewController.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import LMSideBarController

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
//        let navigationBarAppearace = UINavigationBar.appearance()
//
//        navigationBarAppearace.tintColor = UIColor(hexString: "#ffffff")
//        navigationBarAppearace.barTintColor = UIColor(hexString: "#1B1D26")

        let leftMenuItem = UIBarButtonItem(image: UIImage(named: "Menu_icon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(BaseViewController.leftMenuButtonTapped(sender:)))
        
        self.navigationItem.leftBarButtonItem = leftMenuItem
    }
    
    @objc func leftMenuButtonTapped(sender: Any) {
        
        self.sideBarController.showMenuViewController(in: LMSideBarControllerDirection.left)
    }
    
    @objc func rightMenuButtonTapped(sender: Any) {
        
        self.sideBarController.showMenuViewController(in: LMSideBarControllerDirection.right)
    }
    

}
