//
//  ViewModel.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import Foundation

class ViewModel: TableViewViewModelProtocol {
    
    private let shared = NetworkManager.shared
    private var count = 0
    private var drinksCount = 1
    
    weak var networkManager: NetworkManager!
    
    var drinks: Box<Drinks?> = Box(nil)
    var filters: Box<[String]?> = Box(nil)
    var isTheDrinksShowLast: Box<Bool?> = Box(nil)
    
    func cellViewModel(for element: Drink) -> DrinksCellViewModelProtocol? {
        return TableViewCellViewModel.init(drink: element)
    }
    
    //Fetch data from API step by step
    func fetchData() {
        if count < drinksCount {
            shared.loadDrinks(category: self.filters.value?[count]) { (drinks, drinksFilter)  in
                self.filters.value = drinksFilter
                self.drinksCount = drinksFilter.count
                self.drinks.value = drinks
                self.count += 1
            }
        } else {
            self.isTheDrinksShowLast.value = true
        }
    }
    
    //Fetch data from API by selected filters
    func fetchDataWithFilters(filters: String) {
        count = 100
        shared.loadDrinks(category: filters) { (drinks, _) in
            self.drinks.value = drinks
        }
    }
    
}
