//
//  YQCircleProgressView.swift
//  FoodStock
//
//  Created by Talent on 13.03.2020.
//  Copyright © 2020 Talent. All rights reserved.
//

import UIKit

@IBDesignable class CircleProgreeView: UIView {
    
    // MARK: - public
    
    @IBInspectable var borderWidth: CGFloat = 10
    
    @IBInspectable var defaultBorderColor = UIColor.red
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            backGroundIMGV.backgroundColor = backgroundImage == nil ?
                defaultBorderColor : UIColor.clear
            backGroundIMGV.image = backgroundImage
        }
    }
    
    @IBInspectable var animationDuration: Double = 0.3
    
    func setProgress(_ theProgress: Double, animation: Bool = false) {
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = ((bounds.width < bounds.height ?
            bounds.width : bounds.height) / 2) - (borderWidth / 2) - 2
        let startA = -Double.pi / 2
        let endA = (-Double.pi / 2) + Double.pi * 2 * theProgress
        
        let progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.opacity = 1
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.lineWidth = borderWidth
        
        let toPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startA), endAngle: CGFloat(endA), clockwise: true)
        
        if animation {
            let fullEndA = (-Double.pi / 2) + Double.pi * 2 * 0.999
            let fullPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startA), endAngle: CGFloat(fullEndA), clockwise: true)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progress
            animation.toValue = theProgress
            animation.duration = CFTimeInterval(animationDuration)
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isRemovedOnCompletion = false
            progressLayer.add(animation, forKey: nil)
            progressLayer.path = fullPath.cgPath
        } else {
            progressLayer.path = toPath.cgPath
        }
        backGroundIMGV.layer.mask = progressLayer
        
        progress = theProgress
    }
    
    private(set) public var progress: Double = 0
    
    // MARK: - private

    override func layoutSubviews() {
        super.layoutSubviews()
        backGroundIMGV.frame = bounds
        addSubview(backGroundIMGV)
        backGroundIMGV.frame = bounds
        setProgress(progress, animation: false)
    }

    lazy var backGroundIMGV: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.layer.masksToBounds = true
        imgv.backgroundColor = defaultBorderColor
        return imgv
    }()
    
}
