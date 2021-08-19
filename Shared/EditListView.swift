//
//  EditListView.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/20/21.
//

import SwiftUI

struct EditListView: View {
    @Binding var selectMenu: Bool
    @Binding var CalculateMenu: Bool
    @Binding var EditMenu:Bool
    @Binding var addItemMenu:Bool
    @Binding var addCategoryMenu: Bool
    @Binding var updateItemMenu: Bool
    

    @Binding var update_name: String
    @Binding var update_price: String
    @Binding var update_category: String
    
    @Binding var update_Item: Item
    @Binding var update_dimention: [String]
    @State var searchTextAllItem: String = ""
    var items = ModelViewHandler().getAllItems()
    
    var body: some View {
        ZStack{
            //Color(hex: "e9ecef").ignoresSafeArea(.all)
        
        VStack{
            SearchBar(text: $searchTextAllItem)
            List(items.filter({searchTextAllItem.isEmpty ? true : $0.name.lowercased().contains(searchTextAllItem.lowercased())}),
                 id: \.id, children: \.subItems){eachItem in
              
                ItemRow(isSelected: false, item: eachItem, action: {}, showPrice: true).onTapGesture {
                    //if (eachItem.category == "None" || eachItem.category == eachItem.name){
                    
                    self.update_Item = eachItem
                    
                        self.update_name = eachItem.name
                        self.update_price = String(format: "%.2f",eachItem.price)
                        self.update_category = eachItem.category
                        self.EditMenu = false
                        self.updateItemMenu = true
                    var strDimention:[String] = []
                    let doubleDimention: [Double] = eachItem.dimension ?? []
                    if (doubleDimention != nil && doubleDimention.count >= 3){
                        strDimention.append(String(format: "%.2f",doubleDimention[0]))
                        strDimention.append(String(format: "%.2f",doubleDimention[1]))
                        strDimention.append(String(format: "%.2f",doubleDimention[2]))
                    }
                    self.update_dimention = strDimention
                    
                   // }
                    
                    /*
                    if eachItem.name.lowercased() != eachItem.category.lowercased(){
                        self.update_name = eachItem.name
                        self.update_price = String(eachItem.price)
                        self.update_category = eachItem.category
                        self.EditMenu = false
                        self.updateItemMenu = true
                    }
                     */
                }
            }
            HStack{
                Button(action: {
                    self.EditMenu = false
                    self.selectMenu = true
                }, label: {
                    Text("Home")
                        
                }).buttonStyle(BlueButton())
                Button(action: {
                    self.EditMenu = false
                    self.addItemMenu = true
                }, label: {
                    Text("Add Item")
                        
                }).buttonStyle(BlueButton())
                
                Button(action: {
                    self.EditMenu = false
                    self.addCategoryMenu = true
                }, label: {
                    Text("Add Category")
                        
                }).buttonStyle(BlueButton())
                
                
            }//.padding()
        }
    }
    }
}
/*
struct EditListView_Previews: PreviewProvider {
    static var previews: some View {
        EditListView()
    }
}
 */

