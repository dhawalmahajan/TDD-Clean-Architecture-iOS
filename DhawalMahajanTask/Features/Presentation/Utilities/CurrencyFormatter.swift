//
//  CurrencyFormatter.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation

enum CurrencyFormatter {
    static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = "INR"
        f.currencySymbol = "₹"
        f.maximumFractionDigits = 2
        return f
    }()

    static func string(from value: Double) -> String { formatter.string(from: NSNumber(value: value)) ?? "₹0.00" }
}
