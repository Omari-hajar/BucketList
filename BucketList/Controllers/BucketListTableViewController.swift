//
//  BucketListTableViewController.swift
//  BucketList
//
//  Created by Hajar Alomari on 12/12/2021.
//

import UIKit

class BucketListTableViewController: UITableViewController, AddItemTableViewDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var addItemBarBtnItem: UIBarButtonItem!

    var taskList: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        TaskApi.getAllTasks() {
//                   data, response, error in
//                   do {
////                       if let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
////                           print(tasks)
////                            }
//                       let jsonResult = try JSONDecoder().decode([Task].self, from: data!)
//                       DispatchQueue.main.async {
//                           print(jsonResult)
//                           self.taskList = jsonResult
//                            self.tableView.reloadData()
//                       }
//
//                   } catch {
//                       print("Failed to fetch Data")
//                   }
//               }
        fetchAllTasks()
               super.viewDidLoad()
        
        
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = taskList[indexPath.row]
        cell.textLabel?.text = task.objective
        return cell
    }
    
    

    
    //used for clicking an icons to get item position
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
      //  performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Update Task", message: "Enter a text", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = self.taskList[indexPath.row].objective
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
           // print("Text field: \(textField?.text)")
            if let task = textField?.text {
                TaskApi.updateTask(id: self.taskList[indexPath.row].id, objective: task) { data, response, error in
                    print(task)
                    self.fetchAllTasks()
                }
            }
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = taskList[indexPath.row].id
            
            TaskApi.deleteTask(id: id) { data, response, error in
                
            }
            fetchAllTasks()
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! UINavigationController
        if let addVC = (vc.topViewController as? AddItemTableViewController) {
            if (sender as? UIBarButtonItem) != nil {
                addVC.delegate = self
            } else if let indexPath = sender as? IndexPath{
                addVC.delegate = self
                addVC.task = taskList[indexPath.row].objective
                addVC.id = taskList[indexPath.row].id
                
            }
        }
    }
    

    func cancelBtnPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func savedItem(by controller: AddItemTableViewController, with text: String, atIndexPath: NSIndexPath?) {
        fetchAllTasks()
        dismiss(animated: true, completion: nil)
    }
    
    func fetchAllTasks(){
        TaskApi.getAllTasks() {
                   data, response, error in
                   do {
                       let jsonResult = try JSONDecoder().decode([Task].self, from: data!)
                       DispatchQueue.main.async {
                          // print(jsonResult)
                           self.taskList = jsonResult
                            self.tableView.reloadData()
                       }
                       
                   } catch {
                       print("Failed to fetch Data")
                   }
               }
    }
    
}



