//
//  CategoryTableViewController.swift
//  Ning-Expense
//
//  Created by Ning Huang on 16/10/20.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var cm = CategoryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cm.loadData()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cm.categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        // Configure the cell...

        let cat = cm.categories[indexPath.row]
        
        let progress = cat.used / cat.budget
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.frame = CGRect(x: 230, y: 35, width: 130, height: 130)
        progressView.progress = progress
        progressView.progressTintColor = (cat.color as! UIColor)
        cell.contentView.addSubview(progressView)
        
        let tail = progress >= 1 ? "❗️" : ""
        cell.textLabel?.text = cat.name!  + tail
        cell.detailTextLabel?.text = String(format: "%0.2f", cat.budget)
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
            cm.deleteData(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let editVC = storyboard?.instantiateViewController(withIdentifier: "EditCategoryViewController") as? EditCategoryViewController else {
            return
        }
//        let editVC = EditCategoryCodeViewController()
        editVC.catIndex = indexPath.row

//        navigationController?.pushViewController(editVC, animated: true)
    }
}
