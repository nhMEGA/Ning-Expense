//
//  DataManager.swift
//  Ning-Expense
//
//  Created by Ning Huang on 23/10/20.
//

import UIKit
import CoreData

class DataManager {
    var data: [NSManagedObject] = []
    var entity: String
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init(_ entity: String) {
        self.entity = entity
        loadData()
    }
    
    func loadData() {
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        do{
            data = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("Error loading data in \(entity) error:", error)
        }
    }
    
    func saveData() {
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }
    }
    
    func deleteData(_ index:Int) {
        context.delete(data[index])
        saveData()
        data.remove(at: index)
    }
    
}

