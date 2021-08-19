//
//  ModelViewHandler.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/18/21.
//

import Foundation

class ModelViewHandler{
    func getAllItems() -> [Item] {
        /*
        //Get Test data
        let woodSublist: [Item] = [Item(id: 0, name: "Teak wood", cover: "", price: 5.0, category: "Wood", unit: "/kg", selected: false),
                                   Item(id: 1, name: "H wood", cover: "", price: 6.0, category: "Wood", unit: "/kg" , selected: false),
                                   Item(id: 3, name: "M wood", cover: "", price: 7.0, category: "Wood", unit: "/kg" , selected: false)]
        let allData: [Item] = [Item(id: 0, name: "Nail", cover: "", price: 10.0, category: "None", unit: "/dozen", selected: false),
                               Item(id: 1, name: "Wood", cover: "", price: 0, category: "Wood", selected: false, subItems: woodSublist)]
        
 */
        
        //Get Data From DB
        //return allData
        
        return RealmHandler().getAllItem()
    }
    
    func AddItemInDb(itemData: Item) {
        RealmHandler().addItemToDB(item: itemData)
    }
    
    func getCategories() -> [String] {
        var categories: [String] = []
        categories = RealmHandler().getAllItemCategoryFromDB()
        return categories
    }
    
    func getItemByName(itemName: String) -> Item {
        let allItem = getAllItems()
        for each in allItem{
            if each.name == itemName{
                return each
            }
        }
        return Item(id: 0, name: "qwerty", cover: "", price: 0, category: "", selected: false)
    }
    
    func checkItemExist(itemName: String) -> Bool {
        let allItems: [Item] = getAllItems()
        for each in allItems{
            if each.name.lowercased() == itemName.lowercased(){
                return true
            }
        }
        return false
    }
    
    func updateItem(name: String, price: Double) -> Bool {
        let catList = getCategories()
        var isCat: Bool = false
        for each in catList{
            if each.lowercased() == name.lowercased(){
                isCat = true
                break
            }
        }
        RealmHandler().updateItemPrice(name: name, newPrice: price)
        if isCat {
            if containsDimentions(itCategory: name){
                let subItems = getSublist(categoryName: name)
                for each in subItems{
                    let ItemDimention = each.dimension ?? []
                    if each.dimension != nil && ItemDimention.count >= 3{
                        let l = each.dimension?[0] ?? 0
                        let b = each.dimension?[1] ?? 0
                        let h = each.dimension?[2] ?? 0
                        let newprice = price * l * b/12 * h/12
                        
                        RealmHandler().updateItemPrice(name: each.name, newPrice: newprice)
                    }
                }
                //for all items with category
                //priceValue = pricePerCube * l * b/12 * h/12
            }
            
        }
        
        return true
    }
    
    func deleteItemObject(name: String) -> Void {
        let catList = getCategories()
        var isCat: Bool = false
        for each in catList{
            if each.lowercased() == name.lowercased(){
                isCat = true
                break
            }
        }
        if isCat {
            let subItems = getSublist(categoryName: name)
            for each in subItems{
                RealmHandler().deleteItemFromDB(Name: each.name)
            }
        }
        RealmHandler().deleteItemFromDB(Name: name)
        
    
    }
    
    func getSublist(categoryName: String) -> [Item] {
        let allItems = getAllItems()
        for each in allItems{
            if each.name.lowercased() == categoryName.lowercased(){
                return each.subItems ?? []
            }
        }
        return []
    }
    func updateItemData(item: Item) -> Bool {
        return true
    }
    
    func containsDimentions(itCategory: String) -> Bool {
        let temp = ModelViewHandler().getItemByName(itemName: itCategory)
        if temp.name == "qwerty"{
            return false
        }
        if temp.dimension == nil{
            return false
        }
        if temp.dimension?[0] == 999{
            return false
        }
        return true
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
    }
 */
}
