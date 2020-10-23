//
//  TransactionTableViewController.swift
//  Ning-Expense
//
//  Created by Ning Huang on 16/10/20.
//

import UIKit
import CoreData

class TransactionTableViewController: UITableViewController {
    var tm = TransactionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tm.loadData()
        tableView.reloadData()
    }

    // MARK: - Table view

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tm.transactions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath)

        // Configure the cell...

        let tra = tm.transactions[indexPath.row]
        let cat = tra.parentCategory
        let date = Date(timeIntervalSince1970: tra.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        let backgroundColor = cat?.color as? UIColor
        cell.backgroundColor = backgroundColor
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        backgroundColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let textColor = (red*0.299 + green*0.587 + blue*0.114) > 0.186 ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        cell.textLabel?.textColor = textColor
        cell.detailTextLabel?.textColor = textColor
        cell.textLabel?.text = cat?.name
        cell.detailTextLabel?.text = dateFormatter.string(from: date)
        
        let label = UILabel.init(frame: CGRect(x:0,y:0,width:100,height:20))
        label.textAlignment = NSTextAlignment.right
        label.text = String(format: "%0.2f", tra.amount)
        label.textColor = textColor
        cell.accessoryView = label
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tm.deleteData(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditTransaction" {
            let destinationVC = segue.destination as! EditTransactionViewController
            destinationVC.traIndex = tableView.indexPathForSelectedRow!.row
        }
    }
    
}
