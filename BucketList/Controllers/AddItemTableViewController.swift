//
//  AddItemTableViewController.swift
//  BucketList
//
//  Created by Hajar Alomari on 12/12/2021.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewDelegate?
    @IBOutlet weak var itemTextField: UITextField!
    
    var item: String?
    var indexPath: NSIndexPath?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if item != "" && item != nil {
            itemTextField.text = item
        }

     
    }

    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
       // self.dismiss(animated: true, completion: nil)
        delegate?.cancelBtnPressed(by: self)
    }
    
    @IBAction func saveItemBtnPressed(_ sender: UIBarButtonItem) {
        var item = ""
        if itemTextField.text != "" && itemTextField.text != nil {
             item = itemTextField.text!
        }
        delegate?.savedItem(by: self, with: item, atIndexPath: indexPath)
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
