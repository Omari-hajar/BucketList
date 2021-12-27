//
//  AddItemTableViewController.swift
//  BucketList
//
//  Created by Hajar Alomari on 12/12/2021.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    
    @IBOutlet weak var itemTextField: UITextField!
    weak var delegate: AddItemTableViewDelegate?
    var item: String?
    var indexPath: NSIndexPath?
    
    var task: String?
    var id: Int?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if task != "" && task != nil {
            itemTextField.text = task
        }

     
    }

    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
       // self.dismiss(animated: true, completion: nil)
        delegate?.cancelBtnPressed(by: self)
    }
    
    @IBAction func saveItemBtnPressed(_ sender: UIBarButtonItem) {
        
//        if task != nil {
//            if let  item = itemTextField.text {
//                task = item
//            }
//            if let id = id {
//                TaskApi.updateTask(id: id , objective: task!) { data, response, error in
//                    print(id)
//                    print(self.task!)
//                }
//            }
//
//        } else {
            if let  item = itemTextField.text {
                task = item
            }
            TaskApi.addTask(objective: task!) { data, response, error in
                
            }
        
        
//        var item = ""
//        if itemTextField.text != "" && itemTextField.text != nil {
//             item = itemTextField.text!
//        }
       delegate?.savedItem(by: self, with: task!, atIndexPath: indexPath)
       
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   

}
