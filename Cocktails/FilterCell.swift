//
//  FilterCell.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell, CellProtocol {
    
    static var reuseID: String = "FilterCell"
    
    private var drinkLabel = UILabel(text: "")
    private var selectImage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupConstarints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Setup constraints - 
    private func setupConstarints() {
        drinkLabel.translatesAutoresizingMaskIntoConstraints = false
        selectImage.translatesAutoresizingMaskIntoConstraints = false
        drinkLabel.textColor = .gray
        
        self.addSubview(drinkLabel)
        self.addSubview(selectImage)
        
        NSLayoutConstraint.activate([
            
            selectImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            selectImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selectImage.heightAnchor.constraint(equalToConstant: 25),
            selectImage.widthAnchor.constraint(equalToConstant: 25),
            
            drinkLabel.topAnchor.constraint(equalTo: self.topAnchor),
            drinkLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            drinkLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            drinkLabel.trailingAnchor.constraint(equalTo: selectImage.leadingAnchor, constant: -35),
        ])
        
    }

    
    public func configureCell(filter: SelectDrinks) {
        drinkLabel.text = filter.categoryDrink.remove$20()
        selectDeselectDrinks(isTrue: filter.isSelected)
    }
    
    public func selectDeselectDrinks(isTrue: Bool) {
        isTrue ? (selectImage.image = UIImage(named: "check")) : (selectImage.image = nil)
    }

}
