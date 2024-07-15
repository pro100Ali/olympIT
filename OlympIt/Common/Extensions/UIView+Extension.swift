//
//  UIView + Ext.swift
//  OlympIt
//
//  Created by Nariman on 09.03.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
      subviews.forEach(addSubview)
    }
}
