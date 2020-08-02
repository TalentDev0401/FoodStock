//
//  FoodDetailController.swift
//  FoodStock
//
//  Created by Talent on 15.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import MDatePickerView
import NVActivityIndicatorView

class FoodDetailController: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var expirylbl: UILabel!
    @IBOutlet weak var quantitylbl: UILabel!
    @IBOutlet weak var goalquantitylbl: UILabel!
    @IBOutlet weak var unitlbl: UILabel!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var goalQuantity: UITextField!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var dropdowntableview: UITableView!
    @IBOutlet weak var dropdownBtn: UIButton!
    @IBOutlet weak var dropdownheight: NSLayoutConstraint!
    @IBOutlet weak var dropdownbase: UIView!
            
    // MARK: - Properties
    
    let menutitles = ["Kg".localiz(), "L".localiz(), "Lbs".localiz(), "Pcs".localiz()]
    var isOpen = false
    var isEdit = false
    var stockType: String!
    var uuid: String!
    var fooddetailArray: [FoodDetail]!
    var index: Int!
    let firebaseupload = FirebaseUpload()
        
    // MARK: - MDatePicker configuration
    
    lazy var MDate : MDatePickerView = {
        let mdate = MDatePickerView()
        mdate.delegate = self
        mdate.Color = UIColor(red: 0/255, green: 178/255, blue: 113/255, alpha: 1)
        mdate.cornerRadius = 14
        mdate.translatesAutoresizingMaskIntoConstraints = false
        mdate.from = 1920
        mdate.to = 2050
        return mdate
    }()
    
    let Done : UIButton = {
        let but = UIButton(type:.system)
        but.setTitleColor(UIColor.brown, for: .normal)
        but.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        but.setTitle("Done".localiz(), for: .normal)
        but.addTarget(self, action: #selector(RemoveDatePickerView), for: .touchUpInside)
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    @objc func RemoveDatePickerView() {
        
        MDate.removeFromSuperview()
        Done.removeFromSuperview()
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ConfigDropDownMenu()
        self.ConfigView()
        
    }
    
    // - Configure properties
    func ConfigView() {
        
        self.navigationItem.title = stockType.localiz()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())

        let year =  components.year
        let month = components.month
        let day = components.day
        
        self.day.text = "\(day!)"
        self.month.text = "\(month!)"
        self.year.text = "\(year!)"
        
        self.namelbl.text = "Name : ".localiz()
        self.expirylbl.text = "Expiry : ".localiz()
        self.quantitylbl.text = "Quantity : ".localiz()
        self.goalquantitylbl.text = "Goal Quantity : ".localiz()
        self.unitlbl.text = "Unit (Kg, L, Lbs, Pcs) : ".localiz()
        self.name.placeholder = "Please input name".localiz()
        self.quantity.placeholder = "Please input quantity".localiz()
        self.goalQuantity.placeholder = "Please input goal".localiz()
        
        if isEdit {
            self.name.text = self.fooddetailArray[index].foodname.localiz()
            self.day.text = self.fooddetailArray[index].expirydate
            self.month.text = self.fooddetailArray[index].expirymonth
            self.year.text = self.fooddetailArray[index].expiryyear
            self.unit.text = self.fooddetailArray[index].unit.localiz()
            self.quantity.text = self.fooddetailArray[index].quantity.localiz()
            self.goalQuantity.text = self.fooddetailArray[index].goalquantity.localiz()
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // - Initialize DropDownMenu
    func ConfigDropDownMenu() {
        
        dropdownbase.layer.borderWidth = 1.0
        dropdownbase.layer.masksToBounds = false
        dropdownbase.layer.borderColor = UIColor.white.cgColor
        dropdownbase.layer.cornerRadius = 5.0
        dropdownbase.clipsToBounds = true
        
        dropdowntableview.layer.borderWidth = 1.0
        dropdowntableview.layer.masksToBounds = false
        dropdowntableview.layer.borderColor = UIColor.white.cgColor
        dropdowntableview.layer.cornerRadius = 5.0
        dropdowntableview.clipsToBounds = true
        dropdowntableview.separatorStyle = .singleLine
//        dropdowntableview.separatorColor = .gray
                
        self.unit.text = menutitles[0]
        self.dropdownheight.constant = 0
        self.dropdowntableview.isHidden = true
    }
    
    // MARK: - IBActions
    // Go back action
    @IBAction func OnButtonBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // - Open Date Picker
    @IBAction func OnButtonOpenDatePicker(_ sender: Any) {
                
        view.addSubview(MDate)
        NSLayoutConstraint.activate([
            MDate.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            MDate.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            MDate.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            MDate.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        view.addSubview(Done)
        Done.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        Done.topAnchor.constraint(equalTo: MDate.bottomAnchor, constant: 20).isActive = true
    }

    // Save action
    @IBAction func OnButtonSave(_ sender: UIBarButtonItem) {
        
        self.ShowLoadingView()
        
        if self.name.text! == "" {
            self.DismissLoadingView()
            utils.sharedInstance.showAlert(viewController: self, "Missing Field".localiz(), message: "You must input food Name".localiz())
            return
        } else if self.day.text! == "" && self.month.text! == "" && self.year.text! == "" {
            self.DismissLoadingView()
            utils.sharedInstance.showAlert(viewController: self, "Missing Field".localiz(), message: "You must input expiry date".localiz())
            return
        } else if self.quantity.text! == "" {
            self.DismissLoadingView()
            utils.sharedInstance.showAlert(viewController: self, "Missing Field".localiz(), message: "You must input quantity".localiz())
            return
        } else if self.goalQuantity.text! == "" {
            self.DismissLoadingView()
            utils.sharedInstance.showAlert(viewController: self, "Missing Field".localiz(), message: "You must input goal quantity".localiz())
            return
        } else if self.unit.text! == "" {
            self.DismissLoadingView()
            utils.sharedInstance.showAlert(viewController: self, "Missing Field".localiz(), message: "You must select unit".localiz())
            return
        }
        
        var foodDetailDic: [NSDictionary] = [NSDictionary]()
        let fooddetaildic: [String: String] = [Constants.stockType: self.stockType!, Constants.foodname: self.name.text!, Constants.quantity: self.quantity.text!, Constants.goalquantity: self.goalQuantity.text!, Constants.unit: self.unit.text!, Constants.expirydate: self.day.text!, Constants.expirymonth: self.month.text!, Constants.expiryyear: self.year.text!]
        if isEdit {
            let fooddetail = FoodDetail(info: fooddetaildic)
            self.fooddetailArray.remove(at: index)
            self.fooddetailArray.insert(fooddetail, at: index)
            
        }else {
            let fooddetail = FoodDetail(info: fooddetaildic)
            self.fooddetailArray.append(fooddetail)
        }
        
        for item in self.fooddetailArray {
            
            let food: NSDictionary = [Constants.stockType: item.stocktype, Constants.foodname: item.foodname, Constants.quantity: item.quantity, Constants.goalquantity: item.goalquantity, Constants.unit: item.unit, Constants.expirydate: item.expirydate, Constants.expirymonth: item.expirymonth, Constants.expiryyear: item.expiryyear]
            foodDetailDic.append(food)
        }
        
        let stock: NSDictionary = [Constants.stockType: self.stockType!, Constants.uuid: self.uuid!, Constants.foodDetail: foodDetailDic]
        
        self.firebaseupload.UpdateFoodStockData(uuid: self.uuid, stockInfo: stock) { (error) in
            if let error = error {
                self.DismissLoadingView()
                utils.sharedInstance.showAlert(viewController: self, "Uploading Error".localiz(), message: error.localizedDescription)
            } else {
                self.DismissLoadingView()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    
    // Dropdown menu
    @IBAction func OnButtonDropdown(_ sender: Any) {
        
        if !isOpen {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCurlUp, animations: {
            }) { _ in
                self.dropdownheight.constant = 120
                self.dropdowntableview.isHidden = false
                self.isOpen = true
            }
            
        }else {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCurlDown, animations: {
            }) { _ in
                self.dropdownheight.constant = 0
                self.dropdowntableview.isHidden = true
                self.isOpen = false
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

    // - UITextFieldDelegate method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
}

// MARK: - UItableview Delegate and Datasource
extension FoodDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menutitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        }
        
        cell?.textLabel?.text = menutitles[indexPath.row]
        cell?.contentView.backgroundColor = UIColor.darkText
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.textAlignment = .center
        cell?.selectionStyle = .gray
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.unit.text = menutitles[indexPath.row]
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCurlDown, animations: {
        }) { _ in
            self.dropdownheight.constant = 0
            self.dropdowntableview.isHidden = true
            self.isOpen = false
        }
    }
    
}

// MARK: - MDatePickerViewDelegate method

extension FoodDetailController : MDatePickerViewDelegate {
    func mdatePickerView(selectDate: Date) {

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: selectDate)

        let year =  components.year
        let month = components.month
        let day = components.day
        
        self.day.text = "\(day!)"
        self.month.text = "\(month!)"
        self.year.text = "\(year!)"
    }
}

// MARK: - UITapGestureRecorgnizer Delegate
extension FoodDetailController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.dropdowntableview))! {
            return false
        }
        return true
    }
}
