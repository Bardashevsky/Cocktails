//
//  FiltersViewController.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    private var tableView: CustomTableView!
    private var applyButton = UIButton(type: .system)
    
    weak var delegate: ReloadDrinksByFiltersDelegate!
    public var filtersArray: [SelectDrinks] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupConstraintsAndUIElements()
        leftBarButtonItem()
    }
    
    //MARK: - Setup constraints and UI elements -
    private func setupConstraintsAndUIElements() {
        setupTableView()
        setupApplyButton()
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(applyButton)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            applyButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -110),
            applyButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 27),
            applyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -27),
            applyButton.heightAnchor.constraint(equalToConstant: 53),
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        self.tableView = CustomTableView(frame: self.view.bounds)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.reuseID)
    }
    
    private func setupApplyButton() {
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.setTitle("APPLY", for: .normal)
        applyButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        applyButton.backgroundColor = .black
        applyButton.addTarget(self, action: #selector(applyAction(_:)), for: .touchUpInside)
    }
    
    private func leftBarButtonItem() {
        let button =  UIButton(type: .custom)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 40)//move image to the right
        let label = UILabel(frame: CGRect(x: 40, y: 10, width: 100, height: 20))
        label.font = UIFont(name: "Roboto-Regular", size: 24)
        label.text = "Filters"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.backgroundColor =   UIColor.clear
        button.addSubview(label)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    //MARK: - Actions -
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func applyAction(_ sender: UIButton) {
        let outputDrinksArray = filtersArray.filter { $0.isSelected }.map { $0.categoryDrink }
        delegate.reloadDrinksByFiltersDelegate(drinks: outputDrinksArray)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Deinit -
    deinit {
        print(String(describing: type(of: self)) + " " + "is deinited")
    }
    
}

//MARK: - UITableViewDataSource -
extension FiltersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.reuseID) as! FilterCell
        let filter = filtersArray[indexPath.row]
        cell.configureCell(filter: filter)
        
        return cell
    }
}

//MARK: - UITableViewDelegate -
extension FiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filtersArray[indexPath.row].isSelected = !filtersArray[indexPath.row].isSelected
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
