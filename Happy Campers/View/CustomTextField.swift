//
//  CustomTextField.swift
//  Happy Campers
//
//  Created by axMxe on 8/30/18.
//  Copyright © 2018 axMxe. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    override func prepareForInterfaceBuilder() {
        border()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        border()
    }
    
    func border() {
        attributedPlaceholder = NSAttributedString(string: "Enter a search term...", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.borderWidth = 2
        layer.cornerRadius = 5
        clipsToBounds = true
    }
}
