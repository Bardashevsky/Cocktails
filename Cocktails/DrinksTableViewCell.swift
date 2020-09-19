//
//  DrinksTableViewCell.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit
import Alamofire

enum LoadingState {
    case notLoading
    case loading
    case loaded(UIImage)
}

class DrinksTableViewCell: UITableViewCell, CellProtocol {
    
    static var reuseID: String = "DrinksCell"
    
    private var drinksName = UILabel(text: "")
    private var drinksImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    //Activity Indicator in drinks imageView
    private var loadingState: LoadingState = .notLoading {
        didSet {
            switch loadingState {
            case .notLoading:
                drinksImageView.image = nil
                activityIndicator.stopAnimating()
            case .loading:
                drinksImageView.image = nil
                activityIndicator.startAnimating()
            case let .loaded(img):
                drinksImageView.image = img
                activityIndicator.stopAnimating()
            }
        }
    }
    
    //Setup cell from CellViewModel
    weak var viewModel: DrinksCellViewModelProtocol! {
        willSet(viewModel) {
            drinksName.text = viewModel.drinksName
            self.loadingState = .loading
            guard let url = URL(string: viewModel.drinksImage+"/preview") else { return }
            AF.request(url, method: .get).response { response in
               switch response.result {
                case .success(let responseData):
                    guard let image = UIImage(data: responseData!, scale:1) else { return }
                    self.loadingState = .loaded(image)
                case .failure(let error):
                    print("error--->",error)
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstarints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadingState = .notLoading
    }
    
    //MARK: - Setup constraintes -
    private func setupConstarints() {
        drinksName.translatesAutoresizingMaskIntoConstraints = false
        drinksImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        drinksImageView.contentMode = .scaleAspectFit
        drinksImageView.addSubview(activityIndicator)
        
        self.addSubview(drinksName)
        self.addSubview(drinksImageView)
        
        NSLayoutConstraint.activate([
            
            drinksImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            drinksImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            drinksImageView.heightAnchor.constraint(equalToConstant: 100),
            drinksImageView.widthAnchor.constraint(equalToConstant: 100),
            
            activityIndicator.centerXAnchor.constraint(equalTo: drinksImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: drinksImageView.centerYAnchor),
            
            drinksName.topAnchor.constraint(equalTo: self.topAnchor),
            drinksName.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            drinksName.leadingAnchor.constraint(equalTo: drinksImageView.trailingAnchor, constant: 20),
            drinksName.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }

}
