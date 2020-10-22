//
//  EditViewController.swift
//  Ning-Expense
//
//  Created by Ning Huang on 16/10/20.
//

import UIKit

class EditTransactionViewController: UIViewController {
    @IBOutlet weak var transactionCategoryPicker: UIPickerView!
    @IBOutlet weak var transactionDatePicker: UIDatePicker!
    @IBOutlet weak var transactionAmountText: UITextField!
    @IBOutlet weak var transactionCurrencySegment: UISegmentedControl!
    
    var cm = CategoryManager()
    var transactions = [Transaction]()
    var cc = CurrencyConverter()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        transactionCategoryPicker.dataSource = self
        transactionCategoryPicker.delegate = self
        cc.delegate = self
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cm.loadCategories()
        transactionCategoryPicker.reloadAllComponents()
    }
    
    @IBAction func saveTransaction(_ sender: UIBarButtonItem) {
        if Float(transactionAmountText.text ?? "") != nil {
            let currency = transactionCurrencySegment.selectedSegmentIndex == 0 ? "NZD" : "USD"
            if currency == "USD" {
                cc.getRate()
            } else {
                didSaveTransaction(1)
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

//MARK: - CurrencyConverterDelegate
extension EditTransactionViewController: CurrencyConverterDelegate {
    func didSaveTransaction(_ currencyRate: Float) {
        DispatchQueue.main.async {
            let transaction = Transaction(context: self.context)
            transaction.parentCategory = self.cm.categories[self.transactionCategoryPicker.selectedRow(inComponent: 0)]
            transaction.date = self.transactionDatePicker.date.timeIntervalSince1970
            transaction.amount = Float(self.transactionAmountText.text!)! * currencyRate
            self.transactions.append(transaction)
            self.navigationController?.popToRootViewController(animated: true)
            do {
                try self.context.save()
            } catch {
                self.didFailWithError(error: error)
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension EditTransactionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cm.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cm.categories[row].name
    }

//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//    }
}
