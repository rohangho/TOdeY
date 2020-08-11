//
//  CategoryViewControllerTableViewController.swift
//  TOdeY
//
//  Created by Rohan Ghosh on 10/08/20.
//  Copyright © 2020 Rohan Ghosh. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewControllerTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].title
        return cell
    }
    
    
    
    func save()
    {
        do
        {
            try context.save()
        }
        catch{
            print(error)
        }
    }
    


    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        var buffTextFiels = UITextField()
        
        let alert = UIAlertController(title: "Add Categories", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
           
           
            let ab = Category(context: self.context)
            ab.title = buffTextFiels.text!
          
            self.categoryArray.append(ab)
            self.save()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A New Category"
            buffTextFiels = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func loadItems(request: NSFetchRequest<Category> = Category.fetchRequest())
       {
           do{
               categoryArray = try context.fetch(request)
           }catch{
               print(error)
           }
           tableView.reloadData()
           
       }
    
}
