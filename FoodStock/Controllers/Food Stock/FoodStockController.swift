//
//  FoodStockController.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import SwipeCellKit
import NVActivityIndicatorView
import Firebase
import FirebaseDatabase

class FoodStockController: BaseViewController, NVActivityIndicatorViewable {

    // MARK: - IBOutlets
    
    @IBOutlet weak var progressBaseView: UIView!
    @IBOutlet weak var tableView: UITableView!
        
    // MARK: - Properties
    
    var count: CGFloat = 0
    var progressRing: CircularProgressBar!
    var isNew: Bool!
    var indexpath: IndexPath!
    var stockType: String!
    var sectionEdit = false
    
    var menu = [SectionItemProtocol]()
    let firebaseupload = FirebaseUpload()
    let firebasedownload = FirebaseDownload()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Food Stock".localiz()
        self.ConfigurCircularProgressbar()
        self.InitCollapsibleTableView()
    }
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightButton()
        self.DownloadFoodStockData()
    }
    
    // Configure Circular progress bar
    func ConfigurCircularProgressbar() {
        
        let xPosition = self.progressBaseView.frame.origin.x + 100 + (view.frame.width - 200) / 2
        let yPosition = self.progressBaseView.frame.origin.y + 60
        let position = CGPoint(x: xPosition, y: yPosition)
        
        progressRing = CircularProgressBar(radius: 100, position: position, innerTrackColor: .yellow, outerTrackColor: .brown, lineWidth: 20)
        self.progressBaseView.layer.addSublayer(progressRing)
    }
    
    // MARK: - Add right bar button item to Navigation bar
    
    func addRightButton(){

        let viewAdd = UIView(frame: CGRect(x: 0, y: 0, width: 40,height: 40))
        viewAdd.backgroundColor = UIColor.clear
        let add = UIButton(frame: CGRect(x: 0,y: 0, width: 40, height: 40))
        add.setImage(UIImage(named: "add"), for: UIControl.State.normal)
        add.addTarget(self, action: #selector(self.didTapOnAddButton(sender:)), for: UIControl.Event.touchUpInside)
        viewAdd.addSubview(add)
        let addBarButton = UIBarButtonItem(customView: viewAdd)
        
        if self.menu.count > 0 {
            
            let viewEdit = UIView(frame: CGRect(x: 0, y: 0, width: 40,height: 40))
            viewEdit.backgroundColor = UIColor.clear
            let edit = UIButton(frame: CGRect(x: 0,y: 0, width: 40, height: 40))
            if !self.sectionEdit {
                edit.setImage(UIImage(named: "edit"), for: UIControl.State.normal)
            } else {
                edit.setImage(UIImage(named: "done"), for: UIControl.State.normal)
            }
            
            edit.addTarget(self, action: #selector(self.didTapOnEditButton(sender:)), for: UIControl.Event.touchUpInside)
            viewEdit.addSubview(edit)
            let editBarButton = UIBarButtonItem(customView: viewEdit)

            self.navigationItem.rightBarButtonItems = [editBarButton, addBarButton]
        } else {
            self.navigationItem.rightBarButtonItem = addBarButton
        }
    }
    
    @objc func didTapOnAddButton(sender: Any) {
        
        let ac = UIAlertController(title: "Please input food type".localiz(), message: nil, preferredStyle: .alert)
        ac.addTextField()

        let addAction = UIAlertAction(title: "Add".localiz(), style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            self.UploadFoodStockData(stockType: answer.text!)
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss".localiz(), style: .default) { void in
            
            print("dismiss button clicked")
        }
        
        ac.addAction(dismissAction)
        ac.addAction(addAction)

        present(ac, animated: true)
    }
    
    @objc func didTapOnEditButton(sender: Any) {
        
        if self.sectionEdit {
            self.sectionEdit = false
            self.addRightButton()
            self.tableView.reloadData()
        } else {
            self.sectionEdit = true
            self.addRightButton()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Downloading FoodStockData from server
    
    func DownloadFoodStockData() {
        
        ShowLoadingView()
        self.firebasedownload.DownloadFoodStockInfo { (stockData, error) in
            if let error = error {
                self.DismissLoadingView()
                utils.sharedInstance.showAlert(viewController: self, "Downloading Error".localiz(), message: error.localizedDescription)
                return
            }
            
            if let stockData = stockData {
                self.DismissLoadingView()
                self.menu = ModelBuilder.modelGenerator(stockInfo: stockData)
                self.addRightButton()
                self.menu.sort { $0.title.lowercased() < $1.title.lowercased() }
                
                var totaldivide = 0.0
                var count = 0
                self.menu.forEach { (item) in
                    item.items.forEach { (food) in
                        let percent = Double(food.quantity)!/Double(food.goalquantity)!
                        totaldivide += percent
                        count += 1
                    }
                }
                
                let totalpercent = totaldivide/Double(count)*100.0
                self.progressRing.progress = CGFloat(totalpercent.rounded())
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Uploading FoodStockData to server
    func UploadFoodStockData(stockType: String) {
        
        ShowLoadingView()
        
        let uuid = UUID().uuidString
        let stock: NSDictionary = [Constants.stockType: stockType, Constants.uuid: uuid]
        self.firebaseupload.UpdateFoodStockData(uuid: uuid, stockInfo: stock) { (error) in
            if let error = error {
                self.DismissLoadingView()
                utils.sharedInstance.showAlert(viewController: self, "Uploading Error".localiz(), message: error.localizedDescription)
            } else {
                self.DismissLoadingView()
                let section = TableSection()
                section.title = stockType
                section.uuid = uuid
                self.menu.append(section)
                self.addRightButton()
                self.menu.sort { $0.title.lowercased() < $1.title.lowercased() }
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    //MARK: Show Loading view
    func ShowLoadingView() {
        
        // - Starting loading view
        let size = CGSize(width: 70, height: 70)
        startAnimating(size, message: "Loading".localiz(), type: NVActivityIndicatorType.ballSpinFadeLoader, fadeInAnimation: nil)
    }
    
    //MARK: Dismiss loading view
    func DismissLoadingView() {
        
        // - Dismiss loading view
        self.stopAnimating(nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fooddetail" {
            
            if isNew {
                
                let fooddetail = segue.destination as! FoodDetailController
                fooddetail.stockType = self.stockType
                fooddetail.isEdit = false
                fooddetail.uuid = self.model()?[self.indexpath.section].uuid
                fooddetail.fooddetailArray = self.model()?[self.indexpath.section].items
            } else {
                if let indexPath = (sender as? IndexPath) {
                    let fooddetail = segue.destination as! FoodDetailController
                    fooddetail.index = indexPath.row
                    fooddetail.stockType = self.stockType
                    fooddetail.isEdit = true
                    fooddetail.uuid = self.model()?[self.indexpath.section].uuid
                    fooddetail.fooddetailArray = self.model()?[self.indexpath.section].items
                }
            }
        }
    }

    // MARK: - Collapsible table view configuration
    func InitCollapsibleTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib(nibName: "SectionHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
        
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    // MARK: - Utils method for collapsible table view
    func model() -> [SectionItemProtocol]? {
        return menu
    }
    
    func singleOpenSelectionOnly() -> Bool {
        return false
    }
    
    func sectionHeaderReuseIdentifier() -> String? {
        return "SectionHeaderView"
    }
    
    // - Long press gesture recorgnize
    @objc func headerLongPressGesture() {
        // Tap action
    }

}

// MARK: - CollapsibleSectionHeaderTappableProtocol method
extension FoodStockController: CollapsibleSectionHeaderTappableProtocol {
    
    func addRowCell(section: Int) {
        
        if !self.sectionEdit {
         
            self.isNew = true
            self.indexpath = IndexPath(row: 0, section: section)
            self.stockType = self.model()?[section].title
            performSegue(withIdentifier: "fooddetail", sender: self)
        }
    }
    
    func deleteSection(section: Int) {
        
        self.ShowLoadingView()
        for item in menu {
            print(item.title)
        }
        
        let ref = Database.database().reference()
        ref.child("FoodStockAndSpending").child("FoodStock").child(self.menu[section].uuid).removeValue { (error, ref) in
            if let error = error {
                self.DismissLoadingView()
                utils.sharedInstance.showAlert(viewController: self, "Deleting Failed".localiz(), message: error.localizedDescription)
                
                return
            }
            self.menu.remove(at: section)
            self.DismissLoadingView()
            self.tableView.reloadData()
        }
    }
    
    func sectionTapped(view: CollapsibleSectionHeaderProtocol) {
        
        if !self.sectionEdit {
            
            let section = view.tag
            
            tableView.beginUpdates()
            
            var foundOpenUnchosenMenuSection = false
            
            let menu = self.model()
            
            if let menu = menu {
                
                var count = 0
                
                for var menuSection in menu {
                    
                    let chosenMenuSection = (section == count)
                    
                    let isVisible = menuSection.isVisible
                    
                    if isVisible && chosenMenuSection {
                        
                        menuSection.isVisible = false
                        
                        view.close(true)
                        
                        let indexPaths = self.indexPaths(section: section, menuSection: menuSection)
                        
                        tableView.deleteRows(at: indexPaths as [IndexPath], with: (foundOpenUnchosenMenuSection) ? .bottom : .top)
                        
                    } else if !isVisible && chosenMenuSection {
                        
                        menuSection.isVisible = true
                        
                        view.open(true)
                        
                        let indexPaths = self.indexPaths(section: section, menuSection: menuSection)
                        
                        tableView.insertRows(at: indexPaths as [IndexPath], with: (foundOpenUnchosenMenuSection) ? .bottom : .top)
                        
                    } else if isVisible && !chosenMenuSection && self.singleOpenSelectionOnly() {
                        
                        foundOpenUnchosenMenuSection = true
                        
                        menuSection.isVisible = false
                        
                        let headerView = tableView.headerView(forSection: count)
                        
                        if let headerView = headerView as? CollapsibleSectionHeaderProtocol {
                            headerView.close(true)
                        }
                        
                        let indexPaths = self.indexPaths(section: count, menuSection: menuSection)
                        
                        tableView.deleteRows(at: indexPaths as [IndexPath], with: (view.tag > count) ? .top : .bottom)
                    }
                    
                    count += 1
                }
            }
            tableView.endUpdates()
        }
    }
    
    func indexPaths(section: Int, menuSection: SectionItemProtocol) -> [NSIndexPath] {
        var collector = [NSIndexPath]()
        
        var indexPath: NSIndexPath
        for i in 0 ..< menuSection.items.count {
            indexPath = NSIndexPath(row: i, section: section)
            collector.append(indexPath)
        }
        return collector
    }
}

// MARK: - Collapsible Table View Delegate and Datasource
extension FoodStockController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? CollapsibleSectionHeaderProtocol {
            let menuSection = self.model()?[section]
            if (menuSection?.isVisible ?? false) {
                view.open(false)
            } else {
                view.close(false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var view: CollapsibleSectionHeaderProtocol?
        
        if let reuseID = self.sectionHeaderReuseIdentifier() {
            view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseID) as? CollapsibleSectionHeaderProtocol
        }
        
        view?.tag = section
        
        let menuSection = self.model()?[section]
        view?.sectionTitleLabel.text = menuSection!.title.localiz()
        view?.sectionTitleLabel.textColor = UIColor(hexString: "#CBCBCB")
        view?.sectionTitleLabel.font = UIFont.systemFont(ofSize: 21)
        view?.tappableDelegate = self
        
        if self.sectionEdit {
            view?.deleteBtn.isHidden = false
            view?.deleteBtnWidth.constant = 20
        } else {
            view?.deleteBtn.isHidden = true
            view?.deleteBtnWidth.constant = 0
        }
                        
        return view as? UIView
    }
    
}

extension FoodStockController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return (self.model() ?? []).count
     }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuSection = self.model()?[section]
        return (menuSection?.isVisible ?? false) ? menuSection!.items.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodStockCell") as! FoodStockCell
        cell.delegate = self
        let menuSection = self.model()?[ indexPath.section]
        cell.foodName.text = (menuSection?.items[indexPath.row].foodname)!.localiz()
        cell.unit.text = (menuSection?.items[indexPath.row].unit)!.localiz()
        cell.expiryDate.text = "\(menuSection!.items[indexPath.row].expirydate)" + " / " + "\(menuSection!.items[indexPath.row].expirymonth)" + " / " + "\(menuSection!.items[indexPath.row].expiryyear)"
        cell.divide.text = menuSection!.items[indexPath.row].quantity + " / " + menuSection!.items[indexPath.row].goalquantity
        
        let quantity = Double(menuSection!.items[indexPath.row].quantity)!
        let goal = Double(menuSection!.items[indexPath.row].goalquantity)!
        let divide = quantity/goal*100.0
        cell.percentage.text = "\(divide.rounded())%"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.isNew = false
        self.indexpath = indexPath
        self.stockType = self.model()?[indexPath.section].title
        performSegue(withIdentifier: "fooddetail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
}

//MARK: - SwipeTableViewCellDelegate methods
extension FoodStockController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let delete = SwipeAction(style: .default, title: "Delete".localiz()) { (action, indexPath) in
            self.DeleteFood(indexpath: indexPath)
        }
        delete.image = UIImage(named: "trash")
        delete.backgroundColor = UIColor.red
        
        return  (orientation == .right ?  [delete] : [])
        
    }
    
    func DeleteFood(indexpath: IndexPath) {
        
        self.ShowLoadingView()
        
        var foodDetailDic: [NSDictionary] = [NSDictionary]()
        
        var fooddetailArray = self.model()?[indexpath.section].items
        fooddetailArray?.remove(at: indexpath.row)
        
        for item in fooddetailArray! {
            
            let food: NSDictionary = [Constants.stockType: item.stocktype, Constants.foodname: item.foodname, Constants.quantity: item.quantity, Constants.goalquantity: item.goalquantity, Constants.unit: item.unit, Constants.expirydate: item.expirydate, Constants.expirymonth: item.expirymonth, Constants.expiryyear: item.expiryyear]
            foodDetailDic.append(food)
        }
        
        let stock: NSDictionary = [Constants.stockType: (self.model()?[indexpath.section].title)!, Constants.uuid: (self.model()?[indexpath.section].uuid)!, Constants.foodDetail: foodDetailDic]
        
        self.firebaseupload.UpdateFoodStockData(uuid: (self.model()?[indexpath.section].uuid)!, stockInfo: stock) { (error) in
            if let error = error {
                self.DismissLoadingView()
                utils.sharedInstance.showAlert(viewController: self, "Uploading Error".localiz(), message: error.localizedDescription)
            } else {
                self.DismissLoadingView()
                self.DownloadFoodStockData()
            }
        }
    }
}
