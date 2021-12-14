//
//  BucketListTableViewController.swift
//  BucketList
//
//  Created by Hajar Alomari on 12/12/2021.
//

import UIKit

class BucketListTableViewController: UITableViewController, AddItemTableViewDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var addItemBarBtnItem: UIBarButtonItem!
    var listItems = ["Study Swift", "Read", "Play Video Games", "Paint", "Watch Movies"]
    
    // refrence to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var BucketItems: [BucketListItems]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchItems()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BucketItems?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //let item = listItems[indexPath.row]
        let item = BucketItems?[indexPath.row]
        cell.textLabel?.text = item?.name
        return cell
    }
    
    
    //used for clicking row items to perform action
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
//    }
    
    //used for clicking an icons to get item position
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
        
    }
    
   
    //swape to delete
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        BucketItems.remove(at: indexPath.row)
        context.delete((BucketItems?[indexPath.row])!)
        do{
            try context.save()
        }catch{
            print("Failed to Delete Task")
        }
        fetchItems()
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! UINavigationController
        if let addVC = (vc.topViewController as? AddItemTableViewController) {
            if (sender as? UIBarButtonItem) != nil {
                addVC.delegate = self
            } else if let indexPath = sender as? IndexPath{
                addVC.delegate = self
                addVC.item = BucketItems?[indexPath.row].name
                addVC.indexPath = indexPath as NSIndexPath
                
            }
        }
    }
    

    func cancelBtnPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func savedItem(by controller: AddItemTableViewController, with text: String, atIndexPath: NSIndexPath?) {
        if let index = atIndexPath{
            BucketItems?[index.row].name = text
            
            
        } else{
    
        let newItem = BucketListItems(context: context)
        newItem.name = text
    
        }
        
        do{
            try context.save()
        }catch{
            print("Failed to add Task")
        }
       
        fetchItems()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Core Data
    
    func fetchItems(){
        //fetch data from core data to display it into table view
        do{
            BucketItems =  try context.fetch(BucketListItems.fetchRequest())
            //since it is UI Work we reload on main thread (it is the job of main thread to update and handle UI)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }catch{
            print("Failed to retrieve Data")
        }
    }
}


