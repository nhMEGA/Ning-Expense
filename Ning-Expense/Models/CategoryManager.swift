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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init() {
        loadCategories()
    }
    
    mutating func loadCategories (){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try context.fetch(request)
            categories.sort(by: {$0.budget > $1.budget})
        } catch {
            print("Error loading categories \(error)")
        }
    }
    
    func saveData() {
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }
    }
    
    mutating func deleteData(_ index:Int) {
        context.delete(categories[index])
        saveData()
        categories.remove(at: index)
    }
}

