//
//  ViewController.swift
//  Todo
//
//  Created by Yawen Wang on 1/10/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "dfwfw"
        itemArray.append(newItem)
       // newItem.done = "true"
        
        let newItem1 = Item()
        newItem1.title = "sssss"
        itemArray.append(newItem1)
        // newItem.done = "true"
        
        
        
        
        if let items = defaults.array(forKey: "TodoListArray") as?[Item]{
            itemArray = items
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

  
    
    
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("call for ROWatindexpath called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        if item.done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
       
        return cell
    
    }
    
    
    
//MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //print(itemArray[indexPath.row])
        //itemArray[indexPath.row].done =! itemArray[indexPath.row].done
        
         //itemArray[indexPath.row].done = ! itemArray[indexPath.row].done
        
               if itemArray[indexPath.row].done == false{
                        itemArray[indexPath.row].done = true
                    }else{
                        itemArray[indexPath.row].done = false
                    }

        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    
    }
    
    
    
    //Mark -Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            
            textField = alertTextField
            
            //            self.itemArray.append(text)
            //            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
    }

        
        
        
        
        
        
        
        
        
        
        
   
    
}

