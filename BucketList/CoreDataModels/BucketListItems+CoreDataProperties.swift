//
//  BucketListItems+CoreDataProperties.swift
//  BucketList
//
//  Created by Hajar Alomari on 14/12/2021.
//
//

import Foundation
import CoreData


extension BucketListItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BucketListItems> {
        return NSFetchRequest<BucketListItems>(entityName: "BucketListItems")
    }

    @NSManaged public var name: String?

}

extension BucketListItems : Identifiable {

}
