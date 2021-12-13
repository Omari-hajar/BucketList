//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//  Created by Hajar Alomari on 13/12/2021.
//

import UIKit

protocol AddItemTableViewDelegate: AnyObject {
    func savedItem(by controller: AddItemTableViewController, with text: String, atIndexPath: NSIndexPath?)
    func cancelBtnPressed(by controller: AddItemTableViewController)
}
