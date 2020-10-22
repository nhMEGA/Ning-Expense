//
//  CategoryManager.swift
//  Ning-Expense
//
//  Created by Ning Huang on 22/10/20.
//

import UIKit
import CoreData

struct CategoryManager {
    var categories: [Category] = []

    init() {
        loadCategories()
    }
    
    mutating func loadCategories (){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try context.fetch(request)
            categories.sort(by: {$0.budget > $1.budget})
        } catch {
            print("Error loading categories \(error)")
        }
    }
}

