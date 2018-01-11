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
  
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(dataFilePath)
        
        

        loadItems()
        
        
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

        
        
        saveItems()
    
        
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
            
            self.saveItems()
            
            
           // self.tableView.reloadData()
            
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

        
        
        
    //MARK - Model Manupulation Methods
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array,\(error)")
        }
        
        
        self.tableView.reloadData()
    }
        
    
    
    
    func loadItems(){
        
        if let data = try?Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
            
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            } catch{
                print("Error decoding item array,\(error)")
            }
            
        }
        
        
        
        
    }
   
    
}

