//
//  EmployeeDirectory.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 29/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import Foundation

protocol EmployeeDirectory {
    var employees: [Employee] { get }
    var isUpdating: Bool { get }
    
    func update()
}
