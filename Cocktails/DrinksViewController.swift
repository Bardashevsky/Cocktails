//
//  CocktailsViewController.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

//Delegate for apply filters
protocol ReloadDrinksByFiltersDelegate: class {
    func reloadDrinksByFiltersDelegate(drinks: [String])
}

class DrinksViewController: UIViewController {
    
    private let actInd: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private let generator = UIImpactFeedbackGenerator(style: .medium)
    private var flagToLoadMoreDrinks = true
    private var drinksFilter: [String] = []
    private var drinks: [Drinks] = []
    
    private var tableView: CustomTableView!
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel.drinks.bind { [unowned self] in self.bindDrinks(drinks: $0) }
        viewModel.filters.bind { [unowned self] in self.bindDrinksFilter(drinksFilter: $0) }
        viewModel.isTheDrinksShowLast.bind { [unowned self] in self.bindEndResult(isEnd: $0) }
        viewModel.fetchData()
        
        setupTableView()
        showActivityIndicatory()
        leftBarButtonItem()
        rightBarButtonItem()
        self.navigationController?.addShadow()
    }
    
    //MARK: - Bindings -
    private func bindDrinks(drinks: Drinks?) {
        guard let drinks = drinks else { return }
        self.drinks.append(drinks)
        self.actInd.stopAnimating()
        self.tableView.reloadData()
    }
    
    private func bindEndResult(isEnd: Bool?) {
        guard let isEnd = isEnd else { return }
        if isEnd {
            self.showAlert(with: "Drinks list is finished", and: "Change filters?") {
                self.filtersAction()
            }
            self.actInd.stopAnimating()
            print(isEnd)
        }
    }
    private func bindDrinksFilter(drinksFilter: [String]?) {
        guard let drinksFilter = drinksFilter else { return }
        self.drinksFilter = drinksFilter
    }
    
    //MARK: - UI Elements -
    private func setupTableView() {
        self.tableView = CustomTableView(frame: self.view.bounds)
        self.view.addSubview(self.tableView)
        self.tableView.allowsSelection = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(DrinksTableViewCell.self, forCellReuseIdentifier: DrinksTableViewCell.reuseID)
    }
    private func showActivityIndicatory() {
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.color = .lightGray
        actInd.center = self.view.center
        actInd.hidesWhenStopped = true
        actInd.startAnimating()
        self.view.addSubview(actInd)
    }
    private func leftBarButtonItem() {
        let button =  UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        button.imageEdgeInsets = UIEdgeInsets(top: -1, left: 32, bottom: 1, right: -32)//move image to the right
        let label = UILabel(frame: CGRect(x: 3, y: 5, width: 68, height: 28))
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.text = "Drinks"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.backgroundColor =   UIColor.clear
        button.addSubview(label)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    private func rightBarButtonItem() {
        let button =  UIButton(type: .custom)
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.addTarget(self, action: #selector(filtersAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 0)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    //MARK: - Actions -
    @objc private func filtersAction() {
        let filtersVC = FiltersViewController()
        var selectedFilterArray = [SelectDrinks]()
        for filter in drinksFilter {
            selectedFilterArray.append(SelectDrinks(categoryDrink: filter, isSelected: true))
        }
        filtersVC.filtersArray = selectedFilterArray
        filtersVC.delegate = self
         
        self.navigationController?.pushViewController(filtersVC, animated: true)
    }
}

//MARK: - UITableViewDataSource -
extension DrinksViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return drinks[section].category
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.init(name: "Roboto-Regular", size: 16)
        header.textLabel?.textColor = .gray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks[section].drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinksTableViewCell.reuseID) as! DrinksTableViewCell
        let cocktailsGroup = drinks[indexPath.section]
        let cocktail = cocktailsGroup.drinks[indexPath.row]
        
        cell.viewModel = viewModel.cellViewModel(for: cocktail)
        return cell
    }
}

//MARK: - UITableViewDelegate -
extension DrinksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if flagToLoadMoreDrinks && scrollView.contentOffset.y > 0 && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            generator.impactOccurred()
            actInd.startAnimating()
            flagToLoadMoreDrinks = false
            viewModel.fetchData()
        }
        if scrollView.contentOffset.y <= (scrollView.contentSize.height - scrollView.frame.size.height) {
            actInd.stopAnimating()
            flagToLoadMoreDrinks = true
        }
    }
}

extension DrinksViewController: ReloadDrinksByFiltersDelegate {
    func reloadDrinksByFiltersDelegate(drinks: [String]) {
        self.actInd.startAnimating()
        self.drinks.removeAll()
        for drink in drinks {
            viewModel.fetchDataWithFilters(filters: drink)
        }
    }
}
