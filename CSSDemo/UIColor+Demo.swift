//
//  UIColor+Palette.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 23.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var demo_TintColor: UIColor {
        return self.colorWithRed(115, green: 162, blue: 177)
    }
    
    static var demo_UserColor: UIColor {
        return self.colorWithRed(98, green: 138, blue: 92)
    }
    
    static var demo_UserLightColor: UIColor {
        return self.colorWithRed(162, green: 191, blue: 140)
    }
    
    static var demo_BackgroundColor: UIColor {
        return self.colorWithRed(240, green: 234, blue: 207)
    }
    
    static var demo_TextColor: UIColor {
        return self.colorWithRed(96, green: 96, blue: 96)
    }
    
    class func colorWithRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
}