//
//  GradientView.swift
//  Survata Says
//
//  Created by Naomi Hironaka on 7/5/18.
//  Copyright © 2018 iLabs. All rights reserved.
//

import UIKit

@IBDesignable
open class GradientView: UIView {
    @IBInspectable open var color1: UIColor = UIColor.white { didSet { setNeedsDisplay() } }
    @IBInspectable open var color2: UIColor = UIColor.white { didSet { setNeedsDisplay() } }
    @IBInspectable open var loc1: CGPoint = CGPoint(x: 0, y: 0) { didSet { setNeedsDisplay() } }
    @IBInspectable open var loc2: CGPoint = CGPoint(x: 1, y: 1) { didSet { setNeedsDisplay() } }
    
    override open func draw(_ rect: CGRect) {
        drawGradient(rect)
        super.draw(rect)
    }
    
    open func drawGradient(_ rect: CGRect, closure: () -> () = {}) {
        let context = UIGraphicsGetCurrentContext()
        
        context!.saveGState()
        closure()
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1.cgColor, color2.cgColor] as CFArray, locations: [0, 1])
        context!.drawLinearGradient(gradient!,
                                    start: CGPoint(x: rect.size.width * loc1.x, y: rect.size.height * loc1.y),
                                    end: CGPoint(x: rect.size.width * loc2.x, y: rect.size.height * loc2.y),
                                    options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context!.restoreGState()
    }
}
