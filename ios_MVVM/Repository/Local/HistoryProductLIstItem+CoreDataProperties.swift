//
//  HistoryProductLIstItem+CoreDataProperties.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//
//

import Foundation
import CoreData


extension HistoryProductLIstItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryProductLIstItem> {
        return NSFetchRequest<HistoryProductLIstItem>(entityName: "HistoryProductLIstItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var id: String?
    @NSManaged public var desc: String?
    @NSManaged public var loved: Int16

}
