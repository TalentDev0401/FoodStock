//
//  FirebaseDownload.swift
//  Gusto
//
//  Copyright 2018, Spark Anvil LLC. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseCore

class FirebaseDownload {
    
    var ref: DatabaseReference!
    
    // - Downlad ToEat restaurants data from firebase
    func DownloadAppInfo(results: @escaping (_ appinfoes: [String: String]?, _ error: Error?) -> ()) {
        self.ref = Database.database().reference()
        self.ref.child("FoodStockAndSpending/AppInfo").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            var appinfo: [String: String] = [String: String]()
            
            for item in snapshot.children {
                let child = item as! DataSnapshot
                let value = child.value as! String
                appinfo.updateValue(value, forKey: child.key)
            }
            results(appinfo, nil)
            
        }) { (error) in
            print(error.localizedDescription)
            results(nil, error)
        }
    }
    
    // - Download Eaten restaurants data from firebase
    func DownloadSpendingData(results: @escaping (_ spend: [[String: String]]?, _ error: Error?) -> ()) {
        self.ref = Database.database().reference()
        self.ref.child("FoodStockAndSpending/Spending").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            var spendingData: [[String: String]] = [[String: String]]()
            for item in snapshot.children {
                let child = item as! DataSnapshot
                let dict = child.value as! [String: String]
                spendingData.append(dict)
            }
            
            results(spendingData, nil)
            
        }) { (error) in
            print(error.localizedDescription)
            results(nil, error)
        }
    }
    
    // - Download login info data from firebase
    func DownloadFoodStockInfo(results: @escaping (_ foodStock: [NSDictionary]?, _ error: Error?) -> ()) {
        self.ref = Database.database().reference()
        self.ref.child("FoodStockAndSpending/FoodStock").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            var inArray: [NSDictionary] = [NSDictionary]()
            print("snapshot is \(snapshot)")
            for item in snapshot.children {
                let child = item as! DataSnapshot
                if let stocktype = child.value as? String {
                    let stock: NSDictionary = [Constants.stockType: stocktype]
                    inArray.append(stock)
                }else {
                    let dict = child.value as! NSDictionary
                    inArray.append(dict)
                }
            }
            
            results(inArray, nil)
            
        }) { (error) in
            print(error.localizedDescription)
            results(nil, error)
        }
    }
}















