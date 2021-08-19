//
//  StorageItem.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/23/21.
//

import Foundation
import RealmSwift

class StorageItem : Object{
    @objc dynamic var name: String = ""
    @objc dynamic var cover: String = ""
    @objc dynamic var price: Double = 0
    @objc dynamic var category: String = ""
    @objc dynamic var unit: String = ""
    @objc dynamic var dimensionL: Double = 0
    @objc dynamic var dimensionH: Double = 0
    @objc dynamic var dimensionW: Double = 0
    
}

/*
 struct Item: Hashable, Codable, Identifiable {
     var id: Int
     var name: String
     var cover: String
     var price: Double
     var category: String
     var unit: String?
     var selected: Bool
     var count: Int? = 0
     var subItems: [Item]?
     
     var dimension: [Double]? = []
     
 }
 */
