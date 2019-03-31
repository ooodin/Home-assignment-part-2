//
//  EmployeesViewModelDataSource.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 29/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import Foundation

final class EmployeesViewModelDataSource {
    private var employees: [Employee]?
    private let dataSourceAccessQueue = DispatchQueue(
        label: "ru.ooodin.EmployeesSampleProject.dataSourceAccessQueue.async",
        attributes: .concurrent
    )
    
    func setEmployees(_ employees: [Employee]) {
        dataSourceAccessQueue.async(flags: .barrier) {
            self.employees = employees
        }
    }
    
    func getEmployees() -> [Employee]? {
        var currentEmployees: [Employee]?
        dataSourceAccessQueue.sync {
            currentEmployees = self.employees
        }
        return currentEmployees
    }
}
