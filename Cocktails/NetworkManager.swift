//
//  NetworkManager.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    static let shared = NetworkManager()
    
    public func loadDrinks(category: String? = nil, complition: @escaping (Drinks, [String]) -> ()) {
        
        var drinks = [Drink]()
        var localCategory: String = ""
        
        loadFilters { (filtersArray) in
            category == nil ? (localCategory = filtersArray[0]) : (localCategory = category!)
            guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(localCategory)") else { return }
            AF.request(url, method: .get).validate().responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for (_, drink) in json["drinks"] {
                        guard let drinkObject = drink.dictionaryObject else { continue }
                        guard let drink = Drink(dict: drinkObject) else { continue }
                        drinks.append(drink)
                    }
                    complition(Drinks(category: localCategory.remove$20(), drinks: drinks), filtersArray)
                case .failure(let error):
                    print(error)
                }
                
            }
        }
    }
    
    private func loadFilters(complition: @escaping ([String]) -> ()) {
        
        var filterStr = [String]()
        
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list") else { return }
        AF.request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (_, filter) in json["drinks"] {
                    guard let filterObject = filter.dictionaryObject,
                        let filterElement = filterObject["strCategory"] as? String
                        else { continue }
                    filterStr.append(filterElement)
                }
                
                filterStr = filterStr.map { ($0.removeSpace()) }
                complition(filterStr)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
}
