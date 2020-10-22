//
//  EditCategoryViewController.swift
//  Ning-Expense
//
//  Created by Ning Huang on 22/10/20.
//

import UIKit

class EditCategoryViewController: UIViewController {
    @IBOutlet weak var categoryNameText: UITextField!
    @IBOutlet weak var categoryBudgetText: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveCategory(_ sender: UIBarButtonItem) {
        if let budget = Float(categoryBudgetText.text ?? ""), let name = categoryNameText.text {
            let category = Category(context: context)
            category.budget = budget
            category.name = name
            category.color = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            navigationController?.popViewController(animated: true)
            do {
                try self.context.save()
            } catch {
                print(error)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
