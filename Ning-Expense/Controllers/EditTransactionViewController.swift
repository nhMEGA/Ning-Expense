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
    var tm = TransactionManager()
    var cc = CurrencyConverter()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var traIndex = -1
    
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
        cm.loadData()
        transactionCategoryPicker.reloadAllComponents()
        
        if traIndex != -1  {
            let transaction = tm.transactions[traIndex]
            let category = transaction.parentCategory!
            let catIndex = cm.categories.firstIndex(of: category)!
            transactionCategoryPicker.selectRow(catIndex, inComponent: 0, animated: false)
            
            let date = Date(timeIntervalSince1970: transaction.date)
            transactionDatePicker.setDate(date, animated: false)
            
            let amount = transaction.amount
            transactionAmountText.text = String(format: "%0.2f", amount)
        }
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
            let transaction = self.traIndex != -1 ? self.tm.transactions[self.traIndex] : Transaction(context: self.context)
            transaction.parentCategory = self.cm.categories[self.transactionCategoryPicker.selectedRow(inComponent: 0)]
            if self.traIndex != -1{
                transaction.parentCategory!.used -= transaction.amount
            }
            transaction.date = self.transactionDatePicker.date.timeIntervalSince1970
            transaction.amount = Float(self.transactionAmountText.text!)! * currencyRate
            transaction.parentCategory!.used += transaction.amount
            self.navigationController?.popToRootViewController(animated: true)
            self.tm.saveData()
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
