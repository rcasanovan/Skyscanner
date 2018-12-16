//
//  UIColor.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 16/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

extension UIColor {
    
    /**
     * Get the UIColor value from hex
     *
     * - parameters:
     *     - hex: the hex value to transform
     */
    public class func colorWithHex(hex:String) -> UIColor {
        return UIColor.colorWithHex(hex: hex, alpha: 1.0)
    }
    
    /**
     * Get the UIColor value from hex and alpha
     *
     * - parameters:
     *     - hex: the hex value to transform
     *     - alpha: the alpha value for the color
     */
    public class func colorWithHex(hex:String, alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    public class func black() -> UIColor {
        return colorWithHex(hex: "#4e445e")
    }
    
    public class func green() -> UIColor {
        return colorWithHex(hex: "#71e5a7")
    }
    
    public class func gray() -> UIColor {
        return colorWithHex(hex: "#aba6b2")
    }
    
    public class func lightGray() -> UIColor {
        return colorWithHex(hex: "#f6f5f7")
    }
    
    public class func blue() -> UIColor {
        return colorWithHex(hex: "#00b0d5")
    }
    
}
