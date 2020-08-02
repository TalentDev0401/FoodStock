//
//  SpendingController.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import SwipeCellKit
import NVActivityIndicatorView

class SpendingController: BaseViewController, NVActivityIndicatorViewable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var progressbaseView: UIView!
    @IBOutlet weak var progressView: OMCircularProgress!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: - Properties
    var spendings: [[String: String]] = [[String: String]]()
    let firebaseupload = FirebaseUpload()
    let firebasedownload = FirebaseDownload()
    var totalprice = 0.0
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Spending".localiz()
                
        // - Add right bar button
        self.AddRightBarButton()
        
        // - Download spending data from server
        self.DownloadSpendingData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        #if !DISABLE_LOG
        self.progressView.layer.name = "Direct"
        #endif
        
        
    }
        
    // - OMCircularProgress View initialize
    func SetupOMCircularProgress(totalpricevalue: Double) {

        self.progressView.style = .direct
        progressView.animationDuration = 3.0
        progressView.thicknessRatio = 1.0 //100%
                       
        if self.progressView.dataSteps.count > 0 {
            self.progressView.dataSteps.removeAllObjects()
        }
        
        for i in 0..<self.spendings.count {
            
            // create the step.
            var theStep: CPStepData?
            
            // calculate each step's percent
            let eachpercent = Double(self.spendings[i][Constants.spendingprice]!)!/totalpricevalue  
            theStep = self.progressView.addStepWithPercent(eachpercent, color: SharingManager.sharedInstance.colors[i])
                        
            if let theStep = theStep {
                
                theStep.borderRatio            = 0.1
                theStep.border.strokeColor     = SharingManager.sharedInstance.colors[i].darkerColor(percent: 0.6).cgColor
                
                // configure the gradient
                let gradient       = OMShadingGradientLayer(type:.radial)
                
                gradient.function  = .linear
                gradient.frame     = self.progressView.bounds
                
                gradient.colors    = [SharingManager.sharedInstance.colors[i].darkerColor(percent: 0.65),
                                      SharingManager.sharedInstance.colors[i].lighterColor(percent: 1.0),
                                      SharingManager.sharedInstance.colors[i].darkerColor(percent: 0.35)]
                
                gradient.startRadius   = self.progressView.innerRadius / self.progressView.bounds.minRadius
                gradient.endRadius     = self.progressView.outerRadius / self.progressView.bounds.minRadius
                
                // mask it
                theStep.maskLayer        = gradient
                
            }
        }
    }
    
    // Download app info
    func DownloadSpendingData() {
        
        ShowLoadingView()
        self.firebasedownload.DownloadSpendingData { (appInfo, error) in
            
            if let error = error {
                self.DismissLoadingView()
                utils.sharedInstance.showAlert(viewController: self, "Loading Error".localiz(), message: error.localizedDescription)
                return
            }
            
            if let appInfo = appInfo {
                self.DismissLoadingView()
                self.spendings = appInfo
                
                self.spendings.sort { Double($0[Constants.spendingprice]!)! > Double($1[Constants.spendingprice]!)!}
                
                self.totalprice = 0.0
                                                
                self.spendings.forEach { (item) in
                    let eachprice = Double(item[Constants.spendingprice]!)
                    self.totalprice += eachprice!
                }
                
                // - OMCircularProgress view initialize
                self.SetupOMCircularProgress(totalpricevalue: self.totalprice)
                
                for i in 0..<self.spendings.count {
                    self.progressView.setStepProgress(i, stepProgress: 0.98)
                }
                self.totalPrice.text = "\("Total Spending".localiz()) \(self.totalprice)"
                self.tableview.reloadData()
            }
        }
    }
    
    // - Add right navigation bar buttion.
    func AddRightBarButton() {
        
        let viewAdd = UIView(frame: CGRect(x: 0, y: 0, width: 40,height: 40))
        viewAdd.backgroundColor = UIColor.clear
        let add = UIButton(frame: CGRect(x: 0,y: 0, width: 40, height: 40))
        add.setImage(UIImage(named: "add"), for: UIControl.State.normal)
        add.addTarget(self, action: #selector(self.didTapOnAddButton(sender:)), for: UIControl.Event.touchUpInside)
        viewAdd.addSubview(add)
        let addBarButton = UIBarButtonItem(customView: viewAdd)
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc func didTapOnAddButton(sender: Any) {
        
        self.ShowAlertWithMultiText(update: false, spendingtitle: "", spendingprice: "", index: 0)
    }
    
    func ShowAlertWithMultiText(update: Bool, spendingtitle: String, spendingprice: String, index: Int) {
        var title = ""
        if update {
            title = "Update spending data"
        }else {
            title = "Add new Data"
        }
        
        let ac = UIAlertController(title: title.localiz(), message: nil, preferredStyle: .alert)
        ac.addTextField { (textfield) in
            
            if update {
                textfield.text = spendingtitle
            }
            
            textfield.placeholder = "title".localiz()
            textfield.placeHolderColor = UIColor.darkText
            textfield.tintColor = UIColor.black
            textfield.keyboardType = .namePhonePad
        }
        ac.addTextField { (textfield) in
            
            if update {
                textfield.text = spendingprice
            }
            
            textfield.placeholder = "price".localiz()
            textfield.placeHolderColor = UIColor.darkText
            textfield.tintColor = UIColor.black
            textfield.keyboardType = .numberPad
        }
        
        let addAction = UIAlertAction(title: "Add".localiz(), style: .default) { [unowned ac] _ in
            let title = ac.textFields![0]
            let price = ac.textFields![1]
            
            // - Add new Spending data to server
            self.ShowLoadingView()
            
            if title.text! == "" {
                self.DismissLoadingView()
                self.removeFromParent()
                utils.sharedInstance.showAlert(viewController: self, "Missing Field".localiz(), message: "You must input 'spending title'".localiz())
                return
            } else if price.text! == "" {
                self.DismissLoadingView()
                self.removeFromParent()
                utils.sharedInstance.showAlert(viewController: self, "Missing Field".localiz(), message: "You must input 'spending price'".localiz())
                return
            }
            
            let spend: [String: String] = [Constants.spendingtitle: title.text!, Constants.spendingprice: price.text!]
            
            if update {
                self.spendings.remove(at: index)
                self.spendings.insert(spend, at: index)
            }else {
                self.spendings.append(spend)
            }
            
            self.firebaseupload.UpdateSpendingData(with: self.spendings) { (error) in
                if let error = error {
                    self.DismissLoadingView()
                    utils.sharedInstance.showAlert(viewController: self, "Uploading Error".localiz(), message: error.localizedDescription)
                }else {
                    self.DismissLoadingView()
                    
                    self.spendings.sort { Double($0[Constants.spendingprice]!)! > Double($1[Constants.spendingprice]!)!}
                    
                    // - Update total price label value
                    self.totalprice = 0.0
                    self.spendings.forEach { (item) in
                        let eachprice = Double(item[Constants.spendingprice]!)
                        self.totalprice += eachprice!
                    }
                    
                    self.SetupOMCircularProgress(totalpricevalue: self.totalprice)
                    
                    for i in 0..<self.spendings.count {
                        self.progressView.setStepProgress(i, stepProgress: 0.98)
                    }
                    self.totalPrice.text = "\("Total Spending".localiz()) \(self.totalprice)"
                    self.tableview.reloadData()
                }
            }
            
        }
        let dismissAction = UIAlertAction(title: "Dismiss".localiz(), style: .default) { void in
            
            print("dismiss button clicked")
        }
        
        ac.addAction(dismissAction)
        ac.addAction(addAction)

        present(ac, animated: true)
        
    }
    
    //MARK: - NVActivityIndicator
    // Show Loading view
    func ShowLoadingView() {
        
        // - Starting loading view
        let size = CGSize(width: 70, height: 70)
        startAnimating(size, message: "Loading".localiz(), type: NVActivityIndicatorType.ballSpinFadeLoader, fadeInAnimation: nil)
    }
    
    // Dismiss loading view
    func DismissLoadingView() {
        
        // - Dismiss loading view
        self.stopAnimating(nil)
    }
    
}

// MARK:  - UITableViewDelegate and Datasource
extension SpendingController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell") as! SpendingCell
        cell.delegate = self
        
        cell.colorview.backgroundColor = SharingManager.sharedInstance.colors[indexPath.row]
        cell.price.text = "\((Double(spendings[indexPath.row][Constants.spendingprice]!)?.rounded())!)"
        cell.title.text = spendings[indexPath.row][Constants.spendingtitle]!.localiz()
        let percentage = Double(self.spendings[indexPath.row][Constants.spendingprice]!)!/Double(self.totalprice)*100.0
        cell.percent.text = "\(percentage.rounded())%"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - SwipeTableViewCellDelegate methods
extension SpendingController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let delete = SwipeAction(style: .default, title: "Delete".localiz()) { (action, indexPath) in
            
            // - Deleting selected item from server
            self.spendings.remove(at: indexPath.row)
            self.ShowLoadingView()
            self.firebaseupload.UpdateSpendingData(with: self.spendings) { (error) in
                if let error = error {
                    self.DismissLoadingView()
                    utils.sharedInstance.showAlert(viewController: self, "Deleting Failed".localiz(), message: error.localizedDescription)
                }else {
                    self.DismissLoadingView()
                    
                    self.spendings.sort { Double($0[Constants.spendingprice]!)! > Double($1[Constants.spendingprice]!)!}
                    
                    self.totalprice = 0.0
                                                    
                    self.spendings.forEach { (item) in
                        let eachprice = Double(item[Constants.spendingprice]!)
                        self.totalprice += eachprice!
                    }
                    
                    // - OMCircularProgress view initialize
                    self.SetupOMCircularProgress(totalpricevalue: self.totalprice)
                    
                    for i in 0..<self.spendings.count {
                        self.progressView.setStepProgress(i, stepProgress: 0.98)
                    }
                    
                    self.totalPrice.text = "\("Total Spending".localiz()) \(self.totalprice)"
                    self.tableview.reloadData()
                    
                }
            }
            
        }
        delete.image = UIImage(named: "trash")
        delete.backgroundColor = UIColor.red
        
        let edit = SwipeAction(style: .default, title: "Edit".localiz()) { (action, indexPath) in
        
            self.ShowAlertWithMultiText(update: true, spendingtitle: self.spendings[indexPath.row][Constants.spendingtitle]!, spendingprice: self.spendings[indexPath.row][Constants.spendingprice]!, index: indexPath.row)
        }
        edit.image = UIImage(named: "edit")
        edit.backgroundColor = UIColor.brown
        
        return  (orientation == .right ?  [delete, edit] : [])
        
    }
}

