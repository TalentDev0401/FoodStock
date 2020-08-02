//
//  CollapsibleSectionProtocols.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import Foundation
import UIKit

protocol CollapsibleSectionHeaderProtocol {
    
    func open(_ animated: Bool)
    func close(_ animated: Bool)
    
    var sectionTitleLabel: UILabel! { get }
    var deleteBtn: UIButton! { get }
    var deleteBtnWidth: NSLayoutConstraint! { get }
    
    var tappableDelegate: CollapsibleSectionHeaderTappableProtocol! { get set }
    
    var tag: Int { get set }
}

protocol CollapsibleSectionHeaderTappableProtocol {
    
    func sectionTapped(view: CollapsibleSectionHeaderProtocol)
    func addRowCell(section: Int)
    func deleteSection(section: Int)
}

protocol SectionItemProtocol {
    
    var title: String { get }
    var uuid: String { get }
    
    var isVisible: Bool { get set }
    
    var items: [FoodDetail] { get set }
}
