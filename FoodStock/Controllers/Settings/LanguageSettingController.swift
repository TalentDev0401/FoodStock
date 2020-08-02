//
//  LanguageSettingController.swift
//  FoodStock
//
//  Created by Talent on 15.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit

protocol SelectLanguageProtocol {
    func setLanguage(language: String)
}

class LanguageSettingController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    @IBOutlet weak var sixthBtn: UIButton!
    @IBOutlet weak var seventhBtn: UIButton!
    @IBOutlet weak var eighthBtn: UIButton!
    @IBOutlet weak var ninthBtn: UIButton!
    
    @IBOutlet weak var secondlbl: UILabel!
    @IBOutlet weak var thirdlbl: UILabel!
    @IBOutlet weak var forthlbl: UILabel!
    @IBOutlet weak var fifthlbl: UILabel!
    @IBOutlet weak var sixthlbl: UILabel!
    @IBOutlet weak var seventhlbl: UILabel!
    @IBOutlet weak var eighthlbl: UILabel!
    @IBOutlet weak var ninthlbl: UILabel!
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    var clickNumber: Int!
    var delegate: SelectLanguageProtocol?
    var language: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.CircleBtn()
        self.SetTxt()
        self.bottomView.isHidden = true
        
        self.clickNumber = 0
        self.ConfigurationLanguage(lan: language)
    }
    
    // - Get language from server
    func ConfigurationLanguage(lan: String) {
        
        switch lan {
        case "English":
            self.BtnClickEvents(btn: self.firstBtn, index: 1)
        case "Français":
            self.BtnClickEvents(btn: self.secondBtn, index: 2)
        case "Deutsch":
            self.BtnClickEvents(btn: self.thirdBtn, index: 3)
        case "Italiano":
            self.BtnClickEvents(btn: self.fourthBtn, index: 4)
        case "日本語":
            self.BtnClickEvents(btn: self.fifthBtn, index: 5)
        case "한국어":
            self.BtnClickEvents(btn: self.sixthBtn, index: 6)
        case "Dutch":
            self.BtnClickEvents(btn: self.seventhBtn, index: 7)
        case "Español":
            self.BtnClickEvents(btn: self.eighthBtn, index: 8)
        case "Svenska":
            self.BtnClickEvents(btn: self.ninthBtn, index: 9)
        default:
            break
        }
    }
    
    // MARK: - Circling buttons
    func CircleBtn() {
        utils.sharedInstance.CircleBtn(btn: self.firstBtn)
        utils.sharedInstance.CircleBtn(btn: self.secondBtn)
        utils.sharedInstance.CircleBtn(btn: self.thirdBtn)
        utils.sharedInstance.CircleBtn(btn: self.fourthBtn)
        utils.sharedInstance.CircleBtn(btn: self.fifthBtn)
        utils.sharedInstance.CircleBtn(btn: self.sixthBtn)
        utils.sharedInstance.CircleBtn(btn: self.seventhBtn)
        utils.sharedInstance.CircleBtn(btn: self.eighthBtn)
        utils.sharedInstance.CircleBtn(btn: self.ninthBtn)
        
        utils.sharedInstance.RoundBtn(btn: self.doneBtn)
        utils.sharedInstance.RoundBtn(btn: self.skipBtn)
    }
    
    // MARK: - Initialize button's text
    func SetTxt() {
        self.firstBtn.setImage(nil, for: .normal)
        self.firstBtn.setTitle("English", for: .normal)
        self.firstBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.secondBtn.setImage(nil, for: .normal)
        self.secondBtn.setTitle("French", for: .normal)
        self.secondlbl.isHidden = false
        self.secondBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.thirdBtn.setImage(nil, for: .normal)
        self.thirdBtn.setTitle("German", for: .normal)
        self.thirdlbl.isHidden = false
        self.thirdBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.fourthBtn.setImage(nil, for: .normal)
        self.fourthBtn.setTitle("Italian", for: .normal)
        self.forthlbl.isHidden = false
        self.fourthBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.fifthBtn.setImage(nil, for: .normal)
        self.fifthBtn.setTitle("Japanese", for: .normal)
        self.fifthlbl.isHidden = false
        self.fifthBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.sixthBtn.setImage(nil, for: .normal)
        self.sixthBtn.setTitle("Korean", for: .normal)
        self.sixthlbl.isHidden = false
        self.sixthBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.seventhBtn.setImage(nil, for: .normal)
        self.seventhBtn.setTitle("Netherlands", for: .normal)
        self.seventhlbl.isHidden = false
        self.seventhBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.eighthBtn.setImage(nil, for: .normal)
        self.eighthBtn.setTitle("Spanish", for: .normal)
        self.eighthlbl.isHidden = false
        self.eighthBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.ninthBtn.setImage(nil, for: .normal)
        self.ninthBtn.setTitle("Swedish", for: .normal)
        self.ninthlbl.isHidden = false
        self.ninthBtn.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    // MARK: - IBAction
    @IBAction func ClickFirstBtn(sender: Any) {
        self.BtnClickEvents(btn: self.firstBtn, index: 1)
    }
    @IBAction func ClickSecondBtn(sender: Any) {
        self.BtnClickEvents(btn: self.secondBtn, index: 2)
    }
    @IBAction func ClickThirdBtn(sender: Any) {
        self.BtnClickEvents(btn: self.thirdBtn, index: 3)
    }
    @IBAction func ClickFourthBtn(sender: Any) {
        self.BtnClickEvents(btn: self.fourthBtn, index: 4)
    }
    @IBAction func ClickFifthBtn(sender: Any) {
        self.BtnClickEvents(btn: self.fifthBtn, index: 5)
    }
    @IBAction func ClickSixthBtn(sender: Any) {
        self.BtnClickEvents(btn: self.sixthBtn, index: 6)
    }
    @IBAction func ClickSeventhBtn(sender: Any) {
        self.BtnClickEvents(btn: self.seventhBtn, index: 7)
    }
    @IBAction func ClickEighthBtn(sender: Any) {
        self.BtnClickEvents(btn: self.eighthBtn, index: 8)
    }
    @IBAction func ClickNinethBtn(sender: Any) {
        self.BtnClickEvents(btn: self.ninthBtn, index: 9)
    }
    
    @IBAction func ClickDoneBtn(sender: Any) {
        
        let lan = utils.sharedInstance.getLangauge(clickNumber: self.clickNumber)
        // - Change localization
        utils.sharedInstance.ChangeLocalizationwithNativeLanguage(lan: lan)
        delegate?.setLanguage(language: lan)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ClickSkipBtn(sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func BtnClickEvents(btn: UIButton, index: Int) {
        
        if self.clickNumber == 0 {
            btn.backgroundColor = UIColor(hexString: "#4C4D55")
            btn.setImage(UIImage(named: "check"), for: .normal)
            btn.setTitle("", for: .normal)
            btn.tag = 1
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionFlipFromBottom, animations: {
                                
                self.bottomView.alpha = 1
            }) { _ in
                self.bottomView.isHidden = false
            }
            
            self.clickNumber = index
        } else {
            
            if self.clickNumber != index {
                switch self.clickNumber {
                case 1:
                    self.firstBtn.backgroundColor = UIColor(hexString: "#7D7E86")
                    self.firstBtn.setImage(nil, for: .normal)
                    self.firstBtn.setTitle("English", for: .normal)
                    self.firstBtn.tag = 0
                case 2:
                    self.secondBtn.backgroundColor = UIColor(hexString: "#7D7E86")
                    self.secondBtn.setImage(nil, for: .normal)
                    self.secondBtn.setTitle("French", for: .normal)
                    self.secondlbl.isHidden = false
                    self.secondBtn.tag = 0
                case 3:
                    self.thirdBtn.backgroundColor = UIColor(hexString: "#7D7E86")
                    self.thirdBtn.setImage(nil, for: .normal)
                    self.thirdBtn.setTitle("German", for: .normal)
                    self.thirdlbl.isHidden = false
                    self.thirdBtn.tag = 0
                case 4:
                    self.fourthBtn.backgroundColor = UIColor(hexString: "#7D7E86")
                    self.fourthBtn.setImage(nil, for: .normal)
                    self.fourthBtn.setTitle("Italian", for: .normal)
                    self.forthlbl.isHidden = false
                    self.fourthBtn.tag = 0
                case 5:
                    self.fifthBtn.backgroundColor = UIColor(hexString: "#7D7E86")
                    self.fifthBtn.setImage(nil, for: .normal)
                    self.fifthBtn.setTitle("Japanese", for: .normal)
                    self.fifthlbl.isHidden = false
                    self.fifthBtn.tag = 0
                case 6:
                    self.sixthBtn.backgroundColor = UIColor(hexString: "#7D7E86")
                    self.sixthBtn.setImage(nil, for: .normal)
                    self.sixthBtn.setTitle("Korean", for: .normal)
                    self.sixthlbl.isHidden = false
                    self.sixthBtn.tag = 0
                case 7:
                    self.seventhBtn.backgroundColor = UIColor(hexString: "#7D7E86")
                    self.seventhBtn.setImage(nil, for: .normal)
                    self.seventhBtn.setTitle("Netherlands", for: .normal)
                    self.seventhlbl.isHidden = false
                    self.seventhBtn.tag = 0
                case 8:
                    self.eighthBtn.backgroundColor = UIColor(hexString: "#7D7E86")
                    self.eighthBtn.setImage(nil, for: .normal)
                    self.eighthBtn.setTitle("Spanish", for: .normal)
                    self.eighthlbl.isHidden = false
                    self.eighthBtn.tag = 0
                case 9:
                    self.ninthBtn.backgroundColor = UIColor(hexString: "#7D7E86")
                    self.ninthBtn.setImage(nil, for: .normal)
                    self.ninthBtn.setTitle("Swedish", for: .normal)
                    self.ninthlbl.isHidden = false
                    self.ninthBtn.tag = 0
                default:
                    break
                }
            }
            if btn.tag == 0 {
                btn.backgroundColor = UIColor(hexString: "#4C4D55")
                btn.setImage(UIImage(named: "check"), for: .normal)
                btn.setTitle("", for: .normal)
                btn.tag = 1
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionFlipFromBottom, animations: {
                                    
                    self.bottomView.alpha = 1
                }) { _ in
                    self.bottomView.isHidden = false
                }
                self.clickNumber = index
            }else {
                btn.backgroundColor = UIColor(hexString: "#7D7E86")
                btn.setImage(nil, for: .normal)
                btn.setTitle(title, for: .normal)
                btn.tag = 0
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionFlipFromTop, animations: {
                                    
                    self.bottomView.alpha = 0
                }) { _ in
                    
                    self.bottomView.isHidden = true
                }
                self.clickNumber = 0
            }
        }
    }
}
