//
//  EmployeesViewModel.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 28/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import Foundation

final class EmployeesViewModelImpl {
    weak var viewController: EmployeesViewModelDelegate?
    
    private let dataSource: EmployeesViewModelDataSource
    private let curencyFormatter: CurrencyFormatter
    
    init(dataSource: EmployeesViewModelDataSource,
         curencyFormatter: CurrencyFormatter) {
        self.dataSource = dataSource
        self.curencyFormatter = curencyFormatter
        setupSubscriptions()
    }

    deinit {
        removeSubscriptions()
    }
    
    private func updateView() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }

            if let employees = self.dataSource.getEmployees() {
                let dataSource = self.makeEmployeeCellModels(with: employees)
                
                DispatchQueue.main.async {
                    self.viewController?.update(dataSource)
                    self.viewController?.hideLoadingAnimation()
                }
            } else {
                DispatchQueue.main.async {
                    self.viewController?.showLoadingAnimation()
                }
            }
        }
    }
    
    private func makeEmployeeCellModels(with employees: [Employee]) -> [EmployeeCellModel] {
        return employees.map {
            EmployeeCellModel(name: $0.name,
                              birthYear: String($0.birthYear),
                              salary: curencyFormatter.string(with: $0.salary))
        }
    }
}

// MARK: - EmployeesViewModel

extension EmployeesViewModelImpl: EmployeesViewModel {
    func didSetupView() {
        viewController?.showLoadingAnimation()
    }
    
    func sortEmployees() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self, let employees = self.dataSource.getEmployees() else { return }
            let sortedEmployees = employees.sorted { $0.name < $1.name }
            self.dataSource.setEmployees(sortedEmployees)
            self.updateView()
        }
    }
}

// MARK: - Notifications

extension EmployeesViewModelImpl {
    private func setupSubscriptions() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateDidFinish(_:)),
                                               name: Constants.employeeDirectoryDidUpdateNotification,
                                               object: nil)
    }
    
    private func removeSubscriptions() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func updateDidFinish(_ notification: NSNotification) {
        guard let employeeDirectory = notification.object as? EmployeeDirectory else {
            return
        }
        dataSource.setEmployees(employeeDirectory.employees)
        updateView()
    }
}
