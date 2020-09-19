//
//  TableViewViewModelProtocol.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import Foundation

protocol TableViewViewModelProtocol {
    func cellViewModel(for element: Drink) -> DrinksCellViewModelProtocol?
}
