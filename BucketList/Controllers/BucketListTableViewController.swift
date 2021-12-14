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
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = listItems[indexPath.row]
        cell.textLabel?.text = item
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
        listItems.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == SegueIdentifiers().addItem{
//        let navigationController = segue.destination as! UINavigationController
//        let addItemNavController = navigationController.topViewController as! AddItemTableViewController
//        addItemNavController.delegate = self
//        }
//        else if segue.identifier ==  SegueIdentifiers().editItem{
//            let navigationController = segue.destination as! UINavigationController
//            let addItemNavController = navigationController.topViewController as! AddItemTableViewController
//            addItemNavController.delegate = self
//            let indexPath = sender as! NSIndexPath
//            addItemNavController.item = listItems[indexPath.row]
//            addItemNavController.indexPath = indexPath
//        }
//
//    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! UINavigationController
        if let addVC = (vc.topViewController as? AddItemTableViewController) {
            if (sender as? UIBarButtonItem) != nil {
                addVC.delegate = self
            } else if let indexPath = sender as? IndexPath{
                addVC.delegate = self
                addVC.item = listItems[indexPath.row]
                addVC.indexPath = indexPath as NSIndexPath
                
            }
        }
    }
    

    func cancelBtnPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func savedItem(by controller: AddItemTableViewController, with text: String, atIndexPath: NSIndexPath?) {
        if let index = atIndexPath {
            listItems[index.row] = text
            
        } else {
            listItems.append(text)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

}
