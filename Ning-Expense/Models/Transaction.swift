//
//  Transaction.swift
//  Ning-Expense
//
//  Created by Ning Huang on 16/10/20.
//

import Foundation

struct Transaction {
    var category: Category
    var date: TimeInterval
    var amount: Float
    
    init(_ category: Category, _ date: TimeInterval, _ amount: Float) {
        self.category = category
        self.date = date
        self.amount = amount
    }
}

struct TransactionManager {
    
    var transactions = [Transaction(Category("Yellow", #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), 1, 1),
                        Transaction(Category("Green", #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)), 2, 2),
                        Transaction(Category("Red", #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), 3, 3)]
    
    static let singletonTM = TransactionManager()
}
