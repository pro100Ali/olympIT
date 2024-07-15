//
//  UILabel+Extension.swift
//  OlympIt
//
//  Created by Nariman on 13.05.2024.
//

import UIKit

extension UILabel {
    func addUnderline() {
        if let attributedString = attributedText {
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            mutableAttributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = mutableAttributedString
        } else if let text = text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
            attributedText = attributedString
        }
    }
}
