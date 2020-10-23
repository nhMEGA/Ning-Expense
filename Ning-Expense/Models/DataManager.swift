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
    
//    func sortData() {
//        if entity == "Category" {
//            var newdata = data as! [Category]
//            newdata.sort(by: {$0.budget > $1.budget})
//            data = newdata
//        } else {
//            var newdata = data as! [Transaction]
//            newdata.sort(by: {$0.date < $1.date})
//            data = newdata
//        }
//    }
    
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

func deleteAllData(_ entity:String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
    do {
        let results = try context.fetch(fetchRequest)
        for object in results {
            guard let objectData = object as? NSManagedObject else {continue}
            context.delete(objectData)
        }
    } catch let error {
        print("Detele all data in \(entity) error :", error)
    }
}
