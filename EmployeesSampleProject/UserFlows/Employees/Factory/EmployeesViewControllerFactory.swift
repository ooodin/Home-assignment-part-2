//
//  EmployeesFactory.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 28/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import class UIKit.UIViewController

enum EmployeesViewControllerFactory {
    static func makeView() -> UIViewController {
        let dataSource = EmployeesViewModelDataSource()
        let curencyFormatter = CurrencyFormatter()
        
        let viewController = EmployeesViewControllerImpl()
        let viewModel = EmployeesViewModelImpl(dataSource: dataSource,
                                               curencyFormatter: curencyFormatter)
        
        viewController.viewModel = viewModel
        viewModel.viewController = viewController
        
        return viewController
    }
}
