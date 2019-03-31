//
//  CurrencyFormatter.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 29/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import Foundation

final class CurrencyFormatter {
    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencyCode = Constants.salaryCurrencyCode
        formatter.currencyDecimalSeparator = Locale.current.decimalSeparator
        return formatter
    }()
    
    func string(with doubleValue: Double) -> String {
        let value = NSNumber(value: doubleValue)
        return currencyFormatter.string(from: value) ?? ""
    }
}
