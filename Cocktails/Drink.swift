//
//  Drinks.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import Foundation

struct Drink: Equatable {
    var idDrink: String?
    var strDrink: String?
    var strDrinkThumb: String?
    
    init?(dict: [String: Any]) {
        guard
            let idDrink = dict[CodingKeys.idDrink.rawValue] as? String,
            let strDrink = dict[CodingKeys.strDrink.rawValue] as? String,
            let strDrinkThumb = dict[CodingKeys.strDrinkThumb.rawValue] as? String
            
            else { return nil }
        
        self.idDrink = idDrink
        self.strDrink = strDrink
        self.strDrinkThumb = strDrinkThumb
    }
}
extension Drink {
    private enum CodingKeys: String {
        case idDrink
        case strDrink
        case strDrinkThumb
    }
}
