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
    let dataFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
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
        save()
        
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
            self.save()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A New Todo"
            buffTextFiels = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save()
    {
        let encoder = PropertyListEncoder()
        do
        {
            let  datum = try encoder.encode(itemArray)
            try datum.write(to:dataFile!)
           
            
        }
        catch{
            print(error)
        }
    }
    
    func loadItems()
    {
        do{
            let data = try Data(contentsOf: dataFile!)
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([ItemModel].self, from: data)
            }
           
        }
        catch
        {
            print(error)
        }
    }
    
}

