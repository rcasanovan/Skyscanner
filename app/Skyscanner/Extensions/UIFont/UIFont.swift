//
//  UIFont.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 16/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

extension UIFont {
    
    /**
     * Get InterUI Black font
     */
    public class func interUIBlackWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Black", size: size)
    }
    
    /**
     * Get InterUI Black Italic font
     */
    public class func interUIBlackItalicWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-BlackItalic", size: size)
    }
    
    /**
     * Get InterUI Bold font
     */
    public class func interUIBoldWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Bold", size: size)
    }
    
    /**
     * Get InterUI Bold Italic font
     */
    public class func interUIBoldItalicWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-BoldItalic", size: size)
    }
    /**
     * Get InterUI Italic font
     */
    public class func interUIItalicWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Italic", size: size)
    }
    
    /**
     * Get InterUI Medium font
     */
    public class func interUIMediumWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Medium", size: size)
    }
    
    /**
     * Get InterUI Medium Italic font
     */
    public class func interUIMediumItalicWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-MediumItalic", size: size)
    }
    
    /**
     * Get InterUI Regular font
     */
    public class func hoodRegularWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Regular", size: size)
    }
    
}
