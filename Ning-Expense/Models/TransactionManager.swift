//
//  TransactionManager.swift
//  Ning-Expense
//
//  Created by Ning Huang on 22/10/20.
//

import UIKit
import CoreData

class TransactionManager: DataManager {
    var transactions: [Transaction] = []
    init() {
        super.init("Transaction")
        transactions = data as! [Transaction]
        sortData()
    }
    
    func sortData() {
        transactions.sort(by: {$0.date < $1.date})
    }
    override func loadData() {
        super.loadData()
        transactions = data as! [Transaction]
        sortData()
    }
    
    override func deleteData(_ index:Int) {
        transactions[index].parentCategory?.used -= transactions[index].amount
        super.deleteData(index)
    }
}

