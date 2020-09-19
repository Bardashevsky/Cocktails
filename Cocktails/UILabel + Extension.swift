//
//  UILabel + Extension.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = UIFont(name: "Roboto-Regular", size: 16)) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = .gray
    }
}



