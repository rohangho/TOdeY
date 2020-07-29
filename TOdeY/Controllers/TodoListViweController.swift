//
//  ViewController.swift
//  TOdeY
//
//  Created by Rohan Ghosh on 26/07/20.
//  Copyright © 2020 Rohan Ghosh. All rights reserved.
//

import UIKit

class TodoListViweController: UITableViewController {
    
    var itemArray = [ItemModel]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = ItemModel()
        a.name = "rfev"
        a.status = false
        itemArray.append(a)
        if let items = defaults.array(forKey: "abc") as? [ItemModel]{
            itemArray = items
        }
       
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].name
        if(itemArray[indexPath.row].status == true)
        {
           cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(itemArray[indexPath.row].status){
            itemArray[indexPath.row].status = false
        }
        else
        {
          itemArray[indexPath.row].status = true
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


    @IBAction func addTodo(_ sender: UIBarButtonItem)  {
        
        var buffTextFiels = UITextField()
        
        let alert = UIAlertController(title: "Add Todo", message: "", preferredStyle: .alert)
        var action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let ab = ItemModel()
            ab.name = buffTextFiels.text!
            ab.status = false
            self.itemArray.append(ab)
            self.defaults.set(NSKeyedArchiver.archivedData(withRootObject: self.itemArray, requiringSecureCoding: false), forKey: "abc")
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

