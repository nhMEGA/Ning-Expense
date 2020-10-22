//
//  TransactionManager.swift
//  Ning-Expense
//
//  Created by Ning Huang on 22/10/20.
//

import UIKit
import CoreData

struct TransactionManager {
    var transactions: [Transaction] = []

    init() {
        loadTransactions()
    }
    
    mutating func loadTransactions (){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request : NSFetchRequest<Transaction> = Transaction.fetchRequest()
        do{
            transactions = try context.fetch(request)
            transactions.sort(by: {$0.date < $1.date})
        } catch {
            print("Error loading transactions \(error)")
        }
    }
}

