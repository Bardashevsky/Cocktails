//
//  UINavController + Extension.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 13.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

extension UINavigationController {
    func addShadow() {
        self.navigationBar.layer.masksToBounds = false
        self.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationBar.layer.shadowOpacity = 0.8
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationBar.layer.shadowRadius = 2
    }
}
