//
//  TableViewCellViewModelProtocol.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import Foundation

protocol DrinksCellViewModelProtocol: class {
    var drinksName: String { get }
    var drinksImage: String { get }
}
