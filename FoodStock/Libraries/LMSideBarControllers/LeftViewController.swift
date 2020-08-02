//
//  LeftViewController.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import LMSideBarController

class LeftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let localizedfoodstock = NSLocalizedString("Food Stock", comment: "")
    let localizedspending = NSLocalizedString("Spending", comment: "")
    let localizedssettings = NSLocalizedString("Settings", comment: "")
    let localizedprivacy = NSLocalizedString("Privacy Policy", comment: "")
    let localizedscan = NSLocalizedString("Scan", comment: "")
    let localizedinventory = NSLocalizedString("Inventory", comment: "")
    var menuTitles = ["Food Stock".localiz(), "Spending".localiz(), "Settings".localiz(), "Privacy Policy".localiz()]//, "Scan", "Inventory"
    
    let cellIdentifier = "cell"
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var useremail: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        username.text = "Food stock and Spending".localiz()
        
        utils.sharedInstance.CircleImage(image: self.avatarImageView)
        self.avatarImageView.layer.rasterizationScale = UIScreen.main.scale
        self.avatarImageView.layer.shouldRasterize = true
                
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector((userToggledRecording(note:))), name: Notification.Name("ChangeLanguage"), object: nil)
        
    }
    
    @objc func userToggledRecording(note: Notification) {
        
        username.text = "Food stock and Spending".localiz()
        menuTitles.removeAll()
        menuTitles = ["Food Stock".localiz(), "Spending".localiz(), "Settings".localiz(), "Privacy Policy".localiz()]
        self.tableView.reloadData()
    }
    
    @IBAction func CloseFunction(sender: Any) {
        
        let index = SharingManager.sharedInstance.selectindex
        
        self.sideBarController.hideMenuViewController(true)
        
        let navigationController : MainNavigationController = self.sideBarController.contentViewController as! MainNavigationController
        
        if index == 0 {
            navigationController.showFoodStockController()
        } else if index == 1 {
            navigationController.showSpendingController()
        } else if index == 2 {
            navigationController.showScanController()
        } else if index == 3 {
            navigationController.showInventoryController()
        } else if index == 4 {
            navigationController.showSettingsController()
        }
    }
        
    // Tableview datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = self.menuTitles[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor(hexString: "#1B1D26")
        
        return cell
        
    }
    
    //Tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.sideBarController.hideMenuViewController(true)
        
        let navigationController : MainNavigationController = self.sideBarController.contentViewController as! MainNavigationController

        SharingManager.sharedInstance.selectindex = indexPath.row

        if indexPath.row == 0 {
            navigationController.showFoodStockController()
        } else if indexPath.row == 1 {
            navigationController.showSpendingController()
        } else if indexPath.row == 2 {
            navigationController.showSettingsController()
        } else if indexPath.row == 3 {
            if let url = URL(string: "https://live-tracking-live.com/policy") {
                UIApplication.shared.open(url)
            }
        }
    }
}
