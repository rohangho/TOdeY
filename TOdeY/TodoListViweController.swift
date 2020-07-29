//
//  ViewController.swift
//  TOdeY
//
//  Created by Rohan Ghosh on 26/07/20.
//  Copyright © 2020 Rohan Ghosh. All rights reserved.
//

import UIKit

class TodoListViweController: UITableViewController {
    
    var itemArray = ["Todo1","Todo2","Todo3","Todo4"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "abc") as? [String]{
            itemArray = items
        }
       
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark)
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }


    @IBAction func addTodo(_ sender: UIBarButtonItem) {
        
        var buffTextFiels = UITextField()
        
        let alert = UIAlertController(title: "Add Todo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
            self.itemArray.append(buffTextFiels.text!)
            self.defaults.setValue(self.itemArray, forKey: "abc")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A New Todo"
            buffTextFiels = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

