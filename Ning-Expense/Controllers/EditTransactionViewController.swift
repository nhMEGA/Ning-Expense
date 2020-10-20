//
//  EditViewController.swift
//  Ning-Expense
//
//  Created by Ning Huang on 16/10/20.
//

import UIKit

class EditTransactionViewController: UIViewController {
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var currencySegment: UISegmentedControl!
    
    var cm = CategoryManager.singletonCM
    var tm = TransactionManager.singletonTM
    var cc = CurrencyConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        cc.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if Float(amountText.text ?? "") != nil {
            let currency = currencySegment.selectedSegmentIndex == 0 ? "NZD" : "USD"
            if currency == "USD" {
                cc.getRate()
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
        let category = cm.categories[categoryPicker.selectedRow(inComponent: 0)]
        let date = datePicker.date.timeIntervalSince1970
        let amount = Float(amountText.text!)!
        let transaction = Transaction(category, date, amount)
        tm.transactions.append(transaction)
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
