//
//  Filter.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import Foundation

struct Filter {
    var strCategory: String?
    
    init?(dict: [String: Any]) {
        guard let strCategory = dict[CodingKeys.strCategory.rawValue] as? String else { return nil }
        self.strCategory = strCategory
    }
}

extension Filter {
    private enum CodingKeys: String {
        case strCategory
    }
}
