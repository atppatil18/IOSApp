//
//  RealmHandler.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/23/21.
//

import Foundation
import RealmSwift
import Realm
class RealmHandler{
    
    let realm = try! Realm()
    
    func addItemToDB(item: Item) -> Void {
        let storageItemObject = StorageItem()
        storageItemObject.name = item.name
        storageItemObject.cover = item.cover
        storageItemObject.price = item.price
        storageItemObject.category = item.category
        storageItemObject.unit = item.unit ?? "/unit"
        
        
        
        let ItemDimention = item.dimension ?? []
        //print("Dimention data ",ItemDimention)
        //print("Size of dimention ",ItemDimention.count)
        
        if item.dimension == nil || ItemDimention.count < 3{
            storageItemObject.dimensionL = 999
            storageItemObject.dimensionH = 999
            storageItemObject.dimensionW = 999
        }else{
            storageItemObject.dimensionL = item.dimension?[0] ?? 0
            storageItemObject.dimensionH = item.dimension?[1] ?? 0
            storageItemObject.dimensionW = item.dimension?[2] ?? 0
            
        }
        //storageItemObject.dimension = item.dimension ?? []
        realm.beginWrite()
        realm.add(storageItemObject)
        try! realm.commitWrite()
    }
    
    func getAllItem() -> [Item] {
        let allItemsStorageObject = realm.objects(StorageItem.self)
        var itemListForUI = [Item]()//Item
        var i = 1
        var catList = [String]()
        var categoryItems = [Item]()
        var catMap = [String : [Item]] ()
        
        for eachItem in allItemsStorageObject{
            let dimension = [eachItem.dimensionL, eachItem.dimensionH, eachItem.dimensionW]
            let temItem = Item(id: i, name: eachItem.name, cover: eachItem.cover, price: eachItem.price, category: eachItem.category, unit: eachItem.unit, selected: false, count: 0, dimension: dimension)
            itemListForUI.append(temItem)
            i = i+1;
            if eachItem.category != "None"{
                catList.append(eachItem.category)
            }
            if(eachItem.name.lowercased() == eachItem.category.lowercased()){
                categoryItems.append(temItem)
            }
            
        }
        let CatSet = Set(catList)
        for each in CatSet{
            catMap[each] = []
        }
        var itemListSortedForUI = [Item]()//Item
        
        for eachItem in itemListForUI{
            if eachItem.category == "None" {
                itemListSortedForUI.append(eachItem)
            }else{
                if(eachItem.name != eachItem.category){
                    catMap[eachItem.category]?.append(eachItem)
                }
            }
        }
        /*
        //print("Cat Map ")
        for each in catMap.keys {
            print("Key ",each)
            print("Value ", catMap[each])
        }
        */
        for eachItem in itemListForUI{
            var temp = eachItem
            if (temp.category == temp.name){
                temp.subItems = catMap[eachItem.category]
                itemListSortedForUI.append(temp)
            }
            
        }
        
        return itemListSortedForUI
    
    }
    
    func getAllItemCategoryFromDB() -> [String] {
        let allItemsStorageObject = realm.objects(StorageItem.self)
        var i = 1
        var allCategories = [String]()
        for eachItem in allItemsStorageObject{
            
            //let temItem = Item(id: i ,name: eachItem.name, cover: eachItem.cover, price: eachItem.price, category: eachItem.category)
            //itemListForUI.append(temItem)
            allCategories.append(eachItem.category)
            i = i+1;
        }
        
        allCategories.append("None")
        return Array(Set(allCategories))
    }
    
    func deleteItemFromDB(Name: String) -> Bool{
        let allItemsStorageObject = realm.objects(StorageItem.self)
        for eachItem in allItemsStorageObject{
            if (eachItem.name.lowercased() == Name.lowercased()) {
                realm.beginWrite()
                realm.delete(eachItem)
                try! realm.commitWrite()
                return true
            }
        }
        return false
        
    }
    
    func updateItemFromDB(item: Item) -> Bool {
        
        return true
    }

    func updateItemPrice(name :String ,newPrice :Double ) -> Bool {
        print("Inside realm, price is ", newPrice)
        let updateObj = realm.objects(StorageItem.self).filter("name == '"+name+"'").first!
        try! realm.write{
            //let temp = Double (newPrice) ?? 0
            if (newPrice > 0){
                updateObj.price = newPrice
            }
            
        }
        return true
    }
    
    func updateItemDimention(newDimention: [Double]) -> Bool {
        return false
    }
    /*
    
    func updateItemDatainDB(oldName: String, newName:String, newPrice: String) -> Bool {
        
        
        //print("Updating Data from "+oldName+" -> "+newName)
        
        let updateObj = realm.objects(StorageItem.self).filter("name == '"+oldName+"'").first!
        try! realm.write{
            updateObj.name = newName
            let temp = Int (newPrice) ?? 0
            if (temp > 0){
                updateObj.price = temp
            }
            
        }
        
        return true;
    }*/
}
