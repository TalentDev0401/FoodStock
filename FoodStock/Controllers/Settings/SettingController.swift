//
//  SettingController.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MessageUI

class SettingController: BaseViewController, NVActivityIndicatorViewable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lanlbl: UILabel!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var contactlbl: UILabel!
    
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var email: UILabel!
//    @IBOutlet weak var phoneNum: UILabel!
    
    // MARK: - Properties
    let firebaseupload = FirebaseUpload()
    let firebasedownload = FirebaseDownload()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Settings".localiz()
        self.lanlbl.text = "Language : ".localiz()
        self.emaillbl.text = "Email : ".localiz()
        self.contactlbl.text = "Contact Details".localiz()
        self.DownloadAppInfo()
    }
    
    // Download app info
    func DownloadAppInfo() {
        
        ShowLoadingView()
        self.firebasedownload.DownloadAppInfo { (appInfo, error) in
            
            if let error = error {
                self.DismissLoadingView()
                utils.sharedInstance.showAlert(viewController: self, "Loading Error".localiz(), message: error.localizedDescription)
                return
            }
            
            if let appInfo = appInfo {
                self.DismissLoadingView()
                self.SetProperties(info: appInfo)
                
            }
        }
    }
    
    // - Set properties to UI Elements
    func SetProperties(info: [String: String]) {
        self.language.text = info[Constants.language]
        self.email.text = info[Constants.email]
    }
    
    func UploadAppInfo(language: String) {
        
        let inArray: NSDictionary = [Constants.language: language, Constants.email: self.email.text!]
        
        self.firebaseupload.UpdateAppInfo(with: inArray) { (error) in
            
            if let error = error {
                self.DismissLoadingView()
                utils.sharedInstance.showAlert(viewController: self, "Uploading Error".localiz(), message: error.localizedDescription)
            }else {
                self.DismissLoadingView()
                
                // - Change localization
                utils.sharedInstance.ChangeLocalizationwithNativeLanguage(lan: language)
                
                // - Set language to UserDefaults
                let defaults = UserDefaults.standard
                defaults.set(language, forKey: Constants.language)
                self.language.text = language.localiz()
                self.navigationItem.title = "Settings".localiz()
                self.lanlbl.text = "Language : ".localiz()
                self.emaillbl.text = "Email : ".localiz()
                self.contactlbl.text = "Contact Details".localiz()
                
                NotificationCenter.default.post(name: Notification.Name("ChangeLanguage"), object: nil, userInfo: nil)
            }
        }
        
    }
    
    // MARK: - Send email
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["Foodstock2020@gmail.com"])
            mail.setMessageBody("<p>\("Thanks for using my app!".localiz())</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
            print("Can't send email in simulator")
        }
    }
    
    // MARK: - IBActions
    @IBAction func SelectLanuguage(_ sender: Any) {
        performSegue(withIdentifier: "language", sender: self)
    }
    
    @IBAction func ContactViaEmail(_ sender: Any) {
        self.sendEmail()
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
    
    // MARK: - PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "language" {
            let lan = segue.destination as! LanguageSettingController
            lan.language = self.language.text!
            lan.delegate = self
        }
    }
}

// MARK: - SelectLanguageProtocol Delegate method
extension SettingController: SelectLanguageProtocol {
    func setLanguage(language: String) {
        
        ShowLoadingView()
        self.UploadAppInfo(language: language)
    }
}

// MARK: - MFMessageComposserDelegate method
extension SettingController: MFMailComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
    }
}
