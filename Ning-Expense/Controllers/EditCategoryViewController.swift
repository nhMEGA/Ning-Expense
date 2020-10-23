//
//  EditCategoryViewController.swift
//  Ning-Expense
//
//  Created by Ning Huang on 22/10/20.
//

import UIKit
import SnapKit

class EditCategoryViewController: UIViewController {
    @IBOutlet weak var categoryNameText: UITextField!
    @IBOutlet weak var categoryBudgetText: UITextField!
    @IBOutlet weak var categoryColorView: UIView!
    @IBOutlet weak var colorStackView: UIStackView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var color: UIColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    var colorWell: UIColorWell!
    var cm = CategoryManager()
    var catIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addColorWell()
        if catIndex != -1 {
            let category = cm.categories[catIndex]
            categoryNameText.text = category.name
            categoryBudgetText.text = String(format: "%0.2f", category.budget)
            colorWell.selectedColor = (category.color as! UIColor)
        }
    }
    
    @IBAction func saveCategory(_ sender: UIBarButtonItem) {
        if let budget = Float(categoryBudgetText.text ?? ""), let name = categoryNameText.text {
            
            let category = catIndex != -1 ? cm.categories[catIndex] : Category(context: context)
            category.budget = budget
            category.name = name
            category.color = color
            cm.saveData()
            navigationController?.popViewController(animated: true)
        }
    }
    
    func addColorWell() {
        colorWell = UIColorWell()
        categoryColorView.addSubview(colorWell)
//        colorWell.center = categoryColorView.center
        colorWell.snp.makeConstraints { (make) in
            make.center.equalTo(categoryColorView)
        }
        colorWell.title = "Select Color"
        colorWell.selectedColor = color
        colorWell.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
    }

    @objc func colorWellChanged(_ sender: Any) {
        color = colorWell.selectedColor ?? color
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
