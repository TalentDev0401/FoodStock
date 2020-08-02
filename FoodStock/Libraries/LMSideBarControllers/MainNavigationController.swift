//
//  MainNavigationController.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import LMSideBarController

class MainNavigationController: UINavigationController {

    var foodstockViewController = FoodStockController()
    var spendingViewController = SpendingController()
    var scanViewController = ScanController()
    var inventoryViewController = InventoryController()
    var settingsViewController = SettingController()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func foodstockController() -> FoodStockController {
        
        foodstockViewController = (self.storyboard?.instantiateViewController(identifier: "FoodStockController") as? FoodStockController)!
        
        return foodstockViewController
    }
    
    func spendingController() -> SpendingController {
        
        spendingViewController = (self.storyboard?.instantiateViewController(identifier: "SpendingController") as? SpendingController)!
        
        return spendingViewController
    }
    
    func scanController() -> ScanController {
        
        scanViewController = (self.storyboard?.instantiateViewController(identifier: "ScanController") as? ScanController)!
        
        return scanViewController
    }
    
    func inventoryController() -> InventoryController {
        inventoryViewController = (self.storyboard?.instantiateViewController(identifier: "InventoryController") as? InventoryController)!
        return inventoryViewController
    }
    
    func settingController() -> SettingController {
        
        settingsViewController = (self.storyboard?.instantiateViewController(identifier: "SettingController") as? SettingController)!
        return settingsViewController
    }
            
    // SHOW VIEW CONTROLLERS
    func showFoodStockController() {
        self.setViewControllers([self.foodstockController()], animated: true)
    }
        
    func showSpendingController() {
        self.setViewControllers([self.spendingController()], animated: true)
        
    }
        
    func showScanController() {
        self.setViewControllers([self.scanController()], animated: true)
    }
    
    func showInventoryController() {        
        self.setViewControllers([self.inventoryController()], animated: true)
    }
    
    func showSettingsController() {
        self.setViewControllers([self.settingController()], animated: true)
    }
}
