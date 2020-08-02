//
//  FirebaseUpload.swift
//  Gusto
//
//  Copyright 2018, Spark Anvil LLC. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseCore

class FirebaseUpload {
    
    var ref: DatabaseReference!
    
    // - Update App info to firebase
    func UpdateAppInfo(with inArray: NSDictionary, results: @escaping (_ error: Error?) -> ()) {
        
        self.ref = Database.database().reference()
        // - add firebase child node
        let child = ["/FoodStockAndSpending/AppInfo/": inArray]
        
        self.ref.updateChildValues(child, withCompletionBlock: { (error, ref) in
            
            if error == nil {
                results(nil)
            }else {
                results(error)
            }
        })
    }
    
    // - Update Eaten Restaurants to firebase
    func UpdateSpendingData(with inArray: [[String: String]], results: @escaping (_ error: Error?) -> ()) {
        
        self.ref = Database.database().reference()
        // - add firebase child node
        let child = ["/FoodStockAndSpending/Spending/": inArray]
        
        // - Reuploading after deleting selected item
        self.ref.updateChildValues(child, withCompletionBlock: { (error, ref) in
            
            if error == nil {
                results(nil)
            }else {
                results(error)
            }
        })
    }
    
    // - Update Food stock to firebase
    func UpdateFoodStockData(uuid: String, stockInfo: NSDictionary, results: @escaping (_ error: Error?) -> ()) {
        self.ref = Database.database().reference()
        let child = ["/FoodStockAndSpending/FoodStock/\(uuid)/": stockInfo]
        
        // - Write data to Firebase
        self.ref.updateChildValues(child, withCompletionBlock: { (error, ref) in
            
            if error == nil {
                results(nil)
            }else {
                results(error)
            }
            
        })
    }
}
