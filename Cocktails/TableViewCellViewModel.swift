//
//  TableViewCellViewModel.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import Foundation

class TableViewCellViewModel: DrinksCellViewModelProtocol {
    
    private var drink: Drink
    
    var drinksName: String {
        return drink.strDrink!
    }
    var drinksImage: String {
        return drink.strDrinkThumb!
    }
    
    init(drink: Drink) {
        self.drink = drink
    }
}
