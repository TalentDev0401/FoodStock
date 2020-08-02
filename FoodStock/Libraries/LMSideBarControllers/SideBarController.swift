//
//  SideBarController.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import LMSideBarController

class SideBarController: LMSideBarController, LMSideBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SharingManager.sharedInstance.selectindex = 0
        
        let sideBarDepthStyle = LMSideBarDepthStyle()
        sideBarDepthStyle.menuWidth = 300
        
        // Init view controllers
        let leftMenuViewController = self.storyboard?.instantiateViewController(identifier: "LeftViewController") as! LeftViewController
        let navigationController = self.storyboard?.instantiateViewController(identifier: "MainNavigationController") as! MainNavigationController
                
        self.panGestureEnabled = true
        self.delegate = self
        self.setMenuView(leftMenuViewController, for: LMSideBarControllerDirection.left)
        self.setSideBarStyle(sideBarDepthStyle, for: LMSideBarControllerDirection.left)
//        self.setSideBarStyle(sideBarDepthStyle, for: LMSideBarControllerDirection.right)
        self.contentViewController = navigationController
        

        // Do any additional setup after loading the view.
    }
    

    //LMSideBarControllerDelegate methods
    func sideBarController(_ sideBarController: LMSideBarController!, didHideMenuViewController menuViewController: UIViewController!) {
        
    }
    
    func sideBarController(_ sideBarController: LMSideBarController!, didShowMenuViewController menuViewController: UIViewController!) {
        
    }
    
    func sideBarController(_ sideBarController: LMSideBarController!, willHideMenuViewController menuViewController: UIViewController!) {
        
    }
    
    func sideBarController(_ sideBarController: LMSideBarController!, willShowMenuViewController menuViewController: UIViewController!) {
        
    }

}
