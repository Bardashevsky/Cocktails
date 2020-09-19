//
//  String + Extension.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 13.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import Foundation

extension String {
    //Raplace space for network symbols from drinks filter path
    func removeSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
    
    //Replace network symbols with space for display
    func remove$20() -> String {
        return self.replacingOccurrences(of: "%20", with: " ")
    }
}


