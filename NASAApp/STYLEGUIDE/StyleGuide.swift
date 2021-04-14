//
//  StyleGuide.swift
//  NASAApp
//
//  Created by Ludovik on 14/04/2021.
//

import Foundation
import  UIKit

class StyleGuide {
    
    static func getHelveticaNeueWithSize(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "HelveticaNeue", size: size)!
    }
    
    static func getHelveticaNeueBoldWithSize(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "HelveticaNeue-Bold", size: size)!
    }
    
    static func getBlackColor() -> UIColor {
        return UIColor.hex("#151515", alpha: 1.0)
    }
    
    static func getGreyColor () -> UIColor {
        return UIColor.hex("#151515", alpha: 1.0)
    }
    
    static func getNavBarBackgroundColor() -> UIColor {
        return UIColor.hex("#f5f5f5", alpha: 1)
    }
    
}
