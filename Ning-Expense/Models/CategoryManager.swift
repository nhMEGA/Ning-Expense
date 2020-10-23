//
//  CategoryManager.swift
//  Ning-Expense
//
//  Created by Ning Huang on 22/10/20.
//

import UIKit
import CoreData

class CategoryManager: DataManager {
    var categories: [Category] = []

    init() {
        super.init("Category")
        categories = data as! [Category]
        sortData()
    }

    func sortData() {
        categories.sort(by: {$0.budget > $1.budget})
    }
    
    override func loadData() {
        super.loadData()
        categories = data as! [Category]
        sortData()
    }
    
    override func deleteData(_ index: Int) {
        categories.remove(at: index)
        super.deleteData(index)
    }
    
}

