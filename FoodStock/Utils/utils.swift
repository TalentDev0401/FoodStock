//
//  utils.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import Foundation
import UIKit

class utils {
    
    static let sharedInstance = utils()
        
    // Change Localization
    func ChangeLocalization(lan: String) {
        switch lan {
        case "English":
            LanguageManager.shared.setLanguage(language: .en)
        case "French":
            LanguageManager.shared.setLanguage(language: .fr)
        case "German":
            LanguageManager.shared.setLanguage(language: .de)
        case "Italian":
            LanguageManager.shared.setLanguage(language: .it)
        case "Japanese":
            LanguageManager.shared.setLanguage(language: .ja)
        case "Korean":
            LanguageManager.shared.setLanguage(language: .ko)
        case "Netherlands":
            LanguageManager.shared.setLanguage(language: .nl)
        case "Spanish":
            LanguageManager.shared.setLanguage(language: .es)
        case "Swedish":
            LanguageManager.shared.setLanguage(language: .sv)
        default:
            break
        }
    }
    
    func ChangeLocalizationwithNativeLanguage(lan: String) {
        switch lan {
        case "English":
            LanguageManager.shared.setLanguage(language: .en)
        case "Français":
            LanguageManager.shared.setLanguage(language: .fr)
        case "Deutsch":
            LanguageManager.shared.setLanguage(language: .de)
        case "Italiano":
            LanguageManager.shared.setLanguage(language: .it)
        case "日本語":
            LanguageManager.shared.setLanguage(language: .ja)
        case "한국어":
            LanguageManager.shared.setLanguage(language: .ko)
        case "Dutch":
            LanguageManager.shared.setLanguage(language: .nl)
        case "Español":
            LanguageManager.shared.setLanguage(language: .es)
        case "Svenska":
            LanguageManager.shared.setLanguage(language: .sv)
        default:
            break
        }
    }
    
    func getLangauge(clickNumber: Int) -> String {
        
        var language: String!
        switch clickNumber {
        case 1:
            language = "English"
        case 2:
            language = "Français"
        case 3:
            language = "Deutsch"
        case 4:
            language = "Italiano"
        case 5:
            language = "日本語"
        case 6:
            language = "한국어"
        case 7:
            language = "Dutch"
        case 8:
            language = "Español"
        case 9:
            language = "Svenska"
        default:
            break
        }
        
        return language
        
    }
    
    // Circle images
    func CircleImage(image: UIImageView) {
        image.layer.borderWidth=1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.size.height/2
        image.clipsToBounds = true
        
    }
        
    // Round button
    func RoundBtn(btn: UIButton){
        
        btn.layer.cornerRadius = btn.frame.size.height/2
        btn.clipsToBounds = true
        
    }
        
    func CircleBtn(btn: UIButton) {
        
        btn.layer.borderWidth=1.0
        btn.layer.masksToBounds = false
//        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = btn.frame.size.height/2
        btn.clipsToBounds = true
    }
        
    func CircleUIView(view: UIView) {
        
        view.layer.borderWidth=1.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = view.frame.size.height/2
        view.clipsToBounds = true
    }
    
    //MARK: - Show Alert View Controller
    
    func showAlert(viewController: UIViewController, _ title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alertView.view.tintColor = UIColor(hexString: "#FF7345")
        
        viewController.present(alertView, animated: true, completion: nil)
    }
    
}
