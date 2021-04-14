//
//  UILabel+Extension.swift
//  NASAApp
//
//  Created by Ludovik on 14/04/2021.
//

import Foundation
import UIKit

extension UILabel {
    
    func updatedHeight() -> CGFloat {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.textAlignment = textAlignment
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size.height
    }
    
    func updatedAttributedHeight() -> CGFloat {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.textAlignment = textAlignment
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.size.height
    }
    
    func attributedTextFrom(_ text: String, LineHeight lineHeight: CGFloat, Font font: UIFont, TextColor textColor: UIColor){
        let attrString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = lineHeight
        style.lineBreakMode = .byWordWrapping
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: text.count))
        attrString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: text.count))
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: text.count))
        attributedText = attrString
    }
    
    
}
