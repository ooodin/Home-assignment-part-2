//
//  EmployeesViewModelDelegate.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 28/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

protocol EmployeesViewModelDelegate: class {
    func update(_ employees: [EmployeeCellModel])
    func showLoadingAnimation()
    func hideLoadingAnimation()
}
