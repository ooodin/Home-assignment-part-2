//
//  EmployeesViewControllerImpl.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 28/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import UIKit

final class EmployeesViewControllerImpl: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.tableFooterView = UIView()
        
        tableView.register(EmployeeTableViewCell.self,
                           forCellReuseIdentifier: Constants.employeeCellId)
        return tableView
    }()
    
    private lazy var sortBarButtonItem: UIBarButtonItem = {
        let sortButton = UIButton()
        sortButton.addTarget(self, action: #selector(didPressSortButton), for: .touchUpInside)
        sortButton.setTitle("Sort", for: .normal)
        sortButton.setTitle("Sort", for: .highlighted)
        
        sortButton.setTitleColor(.red, for: .normal)
        sortButton.setTitleColor(.gray, for: .highlighted)
        sortButton.setTitleColor(.gray, for: .disabled)
        
        return UIBarButtonItem(customView: sortButton)
    }()
    
    private lazy var loadingView: EmployeeTableLoadingView = {
        let view = EmployeeTableLoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Property
    
    private var dataSource: [EmployeeCellModel] = []
    var viewModel: EmployeesViewModel?
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = UIView()
        setupView()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            assertionFailure("Error viewModel didn't set")
            return
        }
        viewModel.didSetupView()
    }
    
    // MARK: - Actions
    
    @objc
    func didPressSortButton() {
        viewModel?.didPressSortEmployees()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        navigationItem.rightBarButtonItem = sortBarButtonItem
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource

extension EmployeesViewControllerImpl: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard dataSource.indices.contains(indexPath.row) else {
            assertionFailure("dataSource doesn't containt index")
            return UITableViewCell()
        }
        
        let model = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.employeeCellId)
        
        guard let employeeCell = cell as? EmployeeTableViewCell else {
            assertionFailure("tableView didn't register cell for identifier")
            return UITableViewCell()
        }
        employeeCell.name = model.name
        employeeCell.birthYear = model.birthYear
        employeeCell.salary = model.salary
        
        return employeeCell
    }
}

// MARK: - EmployeesViewModelDelegate

extension EmployeesViewControllerImpl: EmployeesViewController {
    func update(_ employees: [EmployeeCellModel]) {
        dataSource = employees
        tableView.reloadData()
    }
    
    func showLoadingAnimation() {
        guard loadingView.superview == nil else { return }
        sortBarButtonItem.isEnabled = false
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        loadingView.startAnimation()
    }
    
    func hideLoadingAnimation() {
        guard loadingView.superview != nil else { return }
        sortBarButtonItem.isEnabled = true
        loadingView.stopAnimation()
        loadingView.removeFromSuperview()
    }
}

// MARK: - Constants

private extension EmployeesViewControllerImpl {
    enum Constants {
        static let estimatedRowHeight = Space.double + Space.quadruple
        static let employeeCellId = "employeeCellId"
    }
}
