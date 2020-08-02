//
//  SectionHeaderView.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit
import CoreGraphics

class SectionHeaderView: UITableViewHeaderFooterView, CollapsibleSectionHeaderProtocol {
    
    var tappableDelegate: CollapsibleSectionHeaderTappableProtocol!
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var deleteBtnWidth: NSLayoutConstraint!
        
    func open(_ animated: Bool) {
        
        if animated && !isRotating {
            
            isRotating = true
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(self.radians(degrees: 180.0)))
            }) {  finished in
                self.isRotating = false
            }

        } else {
            layer.removeAllAnimations()
            arrowImageView.transform = CGAffineTransform.identity
            isRotating = false
        }
    }
    
    func close(_ animated: Bool) {
        
        if animated && !isRotating {
            
            isRotating = true
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.arrowImageView.transform = CGAffineTransform.identity
            }) {  finished in
                self.isRotating = false
            }
        } else {
            layer.removeAllAnimations()
            self.arrowImageView.transform = CGAffineTransform.identity
            self.isRotating = false
        }
    }
    
    private var isRotating = false
    
    func radians(degrees: Double) -> Double {
        return .pi * degrees / 180.0
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        tappableDelegate.sectionTapped(view: self)
    }
    
    @IBAction func AddFood(_ sender: Any) {
        tappableDelegate.addRowCell(section: self.tag)
    }
    
    @IBAction func DeleteSection(_ sender: Any) {
        
        tappableDelegate.deleteSection(section: self.tag)
    }
}


