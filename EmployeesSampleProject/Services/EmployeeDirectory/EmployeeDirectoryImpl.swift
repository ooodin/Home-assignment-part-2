//
//  EmployeeDirectoryImpl.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 29/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import Foundation

final class EmployeeDirectoryImpl: EmployeeDirectory {
    private(set) var employees: [Employee] = []
    private(set) var isUpdating: Bool = false
    
    func update() {
        guard !isUpdating else { return }
        isUpdating = true
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.doUpdateInBackground()
        }
    }
    
    private func doUpdateInBackground() {
        Thread.sleep(forTimeInterval: 2)
        
        let names = [
            "Anne",
            "Lucas",
            "Marc",
            "Zeus",
            "Hermes",
            "Bart",
            "Paul",
            "Jonh",
            "Ringo",
            "Dave",
            "Taylor",
        ]
        
        let surnames = [
            "Hawkins",
            "Simpson",
            "Lennon",
            "Grohl",
            "Hawkins",
            "Jacobs",
            "Holmes",
            "Mercury",
            "Matthews",
        ]
        
        let amount = names.count * surnames.count
        var employees: [Employee] = []
        
        for _ in 0..<amount {
            let name = names[Int.random(in: 0..<names.count)]
            let surname = surnames[Int.random(in: 0..<surnames.count)]
            
            let fullName = "\(name) \(surname)"
            let birthYear = 1997 - Int.random(in: 0...50)
            
            let employee = Employee(name: fullName, birthYear: birthYear)
            employees.append(employee)
        }
        
        DispatchQueue.main.async {
            self.updateDidFinish(with: employees)
        }
    }
    
    private func updateDidFinish(with result: [Employee]) {
        employees = result
        isUpdating = false
        
        NotificationCenter.default.post(name: Constants.employeeDirectoryDidUpdateNotification,
                                        object: self,
                                        userInfo: nil)
    }
}
