//
//  Employee.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 28/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import Foundation

struct Employee {
    let name: String
    let birthYear: Int
    let salary: Double
    
    init(name: String, birthYear: Int) {
        self.name = name
        self.birthYear = birthYear
        self.salary = Constants.startingSalary
    }

    // ToDo: - It's not a high performance decision,
    // to use formatters in models.
//    func formattedSalary() -> String {
//        let formatter = CurrencyFormatter()
//        return formatter.string(with: salary)
//    }
//
//    func birthDate() -> String {
//        return String(birthYear)
//    }
}
