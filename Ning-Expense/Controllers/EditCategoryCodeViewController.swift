//
//  EditCategoryCodeViewController.swift
//  Ning-Expense
//
//  Created by Ning Huang on 23/10/20.
//

import UIKit

class EditCategoryCodeViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoryNameText: UITextField!
    var categoryBudgetText: UITextField!
    var categoryColorWell: UIColorWell!
    var color: UIColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    var cm = CategoryManager()
    var catIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareAutoLayout()
        if catIndex != -1 {
            let category = cm.categories[catIndex]
            categoryNameText.text = category.name
            categoryBudgetText.text = String(format: "%0.2f", category.budget)
            categoryColorWell.selectedColor = (category.color as! UIColor)
        }
    }
    
    @objc func saveCategory() {
        if let budget = Float(categoryBudgetText.text ?? ""), let name = categoryNameText.text {
            let category = catIndex != -1 ? cm.categories[catIndex] : Category(context: context)
            category.budget = budget
            category.name = name
            category.color = color
            cm.saveData()
            navigationController?.popViewController(animated: true)
        }
    }
    
    func prepareAutoLayout () {
        view.backgroundColor = .white
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveCategory))
        self.navigationItem.setRightBarButton(saveButton, animated: true)
        
        let categoryNameLabel = UILabel()
        categoryNameLabel.text = "Name"
        view.addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64 + 16)
            make.left.equalTo(view).offset(8)
            make.width.equalTo(100)
        }
        
        categoryNameText = UITextField()
        categoryNameText.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(categoryNameText)
        categoryNameText.snp.makeConstraints { (make) in
            make.centerY.equalTo(categoryNameLabel)
            make.left.equalTo(categoryNameLabel.snp.right).offset(8)
            make.width.equalTo(200)
        }
        
        let categoryBudgetLabel = UILabel()
        categoryBudgetLabel.text = "Budget"
        view.addSubview(categoryBudgetLabel)
        categoryBudgetLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryNameLabel.snp.bottom).offset(24)
            make.left.equalTo(view).offset(8)
            make.width.equalTo(100)
        }
        
        categoryBudgetText = UITextField()
        categoryBudgetText.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(categoryBudgetText)
        categoryBudgetText.snp.makeConstraints { (make) in
            make.centerY.equalTo(categoryBudgetLabel)
            make.left.equalTo(categoryBudgetLabel.snp.right).offset(8)
            make.width.equalTo(200)
        }
        
        let categoryColorLabel = UILabel()
        categoryColorLabel.text = "Color"
        view.addSubview(categoryColorLabel)
        categoryColorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryBudgetLabel.snp.bottom).offset(24)
            make.left.equalTo(view).offset(8)
            make.width.equalTo(100)
        }
        
        categoryColorWell = UIColorWell()
        categoryColorWell.title = "Pick Category Color"
        categoryColorWell.selectedColor = color
        categoryColorWell.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
        view.addSubview(categoryColorWell)
        categoryColorWell.snp.makeConstraints { (make) in
            make.centerY.equalTo(categoryColorLabel)
            make.left.equalTo(categoryColorLabel.snp.right).offset(8)
        }
    }
    
    @objc func colorWellChanged(_ sender: Any) {
        color = categoryColorWell.selectedColor ?? color
    }
}
