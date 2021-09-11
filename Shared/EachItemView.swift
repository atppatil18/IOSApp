//
//  EachItemView.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/20/21.
//

import SwiftUI

struct EachItemView: View {
    
    @Binding var EditMenu:Bool
    @Binding var addItemMenu:Bool
    @Binding var allUnit: [String]
    @State var name: String = ""
    @State var price: String = ""
    @State var showAlert = false
    @State var emptyAlert = false
    @State var allCategory = ModelViewHandler().getCategories() //["None", "Wood", "Pipe"]//RealmHandler().getAllItemCategoryFromDB()//
    @State var selectedCategory: String = "None"
    
    
    @State var selectedUnit: String = "None"
    
    @State var length: String = "0"
    @State var breadth: String = "0"
    @State var height: String = "0"
    var body: some View {
        VStack{
            
            HStack{
                Text("Name: ")
                    .padding()
                    .frame(width: 150)
                    .font(Font.system(size: 15))
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                TextField("", text: $name)
                    .padding()
                    .font(Font.system(size: 15))
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Duplicate entry"))
                    })
            }
            .padding()
            
            HStack{
                Text("Price: ")
                    .padding()
                    .frame(width: 150)
                    .font(Font.system(size: 15))
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                TextField("", text: $price )
                    .padding()
                    .font(Font.system(size: 15))
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    .alert(isPresented: $emptyAlert, content: {
                        Alert(title: Text("Empty data"))
                    })
                
            }.padding()
            
            HStack{
                
                if self.selectedCategory == "None"{
                    Text("Unit: ")
                        .padding()
                        .frame(width: 75)
                        .font(Font.system(size: 13))
                        .background(Color(hex: "F5F5F5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    Picker("", selection: $selectedUnit) {
                        ForEach(self.allUnit, id: \.self) {
                            Text($0)
                                .font(Font.system(size: 13))
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 200, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    
                }
                
                
                
                Section {
                    Text("Category: ")
                        .padding()
                        .frame(width: 100)
                        .font(Font.system(size: 13))
                        .background(Color(hex: "F5F5F5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    Picker("", selection: $selectedCategory) {
                        ForEach(allCategory, id: \.self) {
                            Text($0)
                                .font(Font.system(size: 13))
                        }
                    }
                    //.pickerStyle(WheelPickerStyle())
                    .pickerStyle(DefaultPickerStyle())
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 200, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    
                }
            }.padding()
            
            
            
            
            if self.selectedCategory != "None"{
                //Get if dimention need
                //then show dimention input
                if containsDimentions(itCategory: self.selectedCategory){
                    
                    VStack{
                        HStack{
                            Text("Length ft: ")
                                .padding()
                                .frame(width: 150)
                                .font(Font.system(size: 15))
                                .background(Color(hex: "F5F5F5"))
                                .cornerRadius(16)
                                .shadow(color: .gray, radius: 2, x: 2, y: 3)
                            TextField("Ft", text: $length )
                                .padding()
                                .font(Font.system(size: 15))
                                .background(Color(hex: "F5F5F5"))
                                .cornerRadius(16)
                                .shadow(color: .gray, radius: 2, x: 2, y: 3)
                                .alert(isPresented: $emptyAlert, content: {
                                    Alert(title: Text("Empty data"))
                                })
                            
                        }
                        HStack{
                            Text("Width inch: ")
                                .padding()
                                .frame(width: 150)
                                .font(Font.system(size: 15))
                                .background(Color(hex: "F5F5F5"))
                                .cornerRadius(16)
                                .shadow(color: .gray, radius: 2, x: 2, y: 3)
                            
                            TextField("Inch", text: $breadth )
                                .padding()
                                .font(Font.system(size: 15))
                                .background(Color(hex: "F5F5F5"))
                                .cornerRadius(16)
                                .shadow(color: .gray, radius: 2, x: 2, y: 3)
                                .alert(isPresented: $emptyAlert, content: {
                                    Alert(title: Text("Empty data"))
                                })
                            
                        }
                        HStack{
                            Text("Heigth inch: ")
                                .padding()
                                .frame(width: 150)
                                .font(Font.system(size: 15))
                                .background(Color(hex: "F5F5F5"))
                                .cornerRadius(16)
                                .shadow(color: .gray, radius: 2, x: 2, y: 3)
                            
                            TextField("Inch", text: $height )
                                .padding()
                                .font(Font.system(size: 15))
                                .background(Color(hex: "F5F5F5"))
                                .cornerRadius(16)
                                .shadow(color: .gray, radius: 2, x: 2, y: 3)
                                .alert(isPresented: $emptyAlert, content: {
                                    Alert(title: Text("Empty data"))
                                })
                            
                        }
                        
                        
                        
                    }
                }
                
            }
            
            HStack{
                
                Button(action: {
                    self.addItemMenu = false
                    self.EditMenu = true
                }, label: {
                    Text("Back")
                    
                }).buttonStyle(BlueButton())
                Button(action: {
                    
                    if addNewItem(itName: name, itPrice: price, itCategory: selectedCategory, itUnit: selectedUnit, lenths: length, breadths: breadth, heights: height){
                        //Added
                        self.addItemMenu = false
                        self.EditMenu = true
                        
                        print("Item added")
                    }else{
                        //Failed to add
                        print("Item added failed")
                    }
                    /*
                     let added = addItemToDB(item: self.name, price: self.price, category: self.selectedCategory, unit: self.selectedUnit)
                     if added {
                     self.showListView = true
                     self.showAddItem = false
                     self.showAddCategory = false
                     self.showEditItem = false
                     }
                     */
                    
                    self.addItemMenu = false
                    self.EditMenu = true
                    
                }, label: {
                    Text("Add")
                    
                }).buttonStyle(BlueButton())
            }
            
        }//.padding()
        
        
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
    func addNewItem(itName: String, itPrice: String, itCategory: String, itUnit: String, lenths: String, breadths: String, heights: String) -> Bool {
        if itName.isEmpty{
            return false
        }
        if itPrice.isEmpty && itCategory == "None"{
            return false
        }
        if self.selectedCategory.lowercased() == itName.lowercased(){
            return false
        }
        
        let handler = ModelViewHandler()
        if handler.checkItemExist(itemName: itName){
            return false
        }
        
        
        
        if self.selectedCategory == "Wood"{
            if self.length.isEmpty || self.breadth.isEmpty || self.height.isEmpty {
                print("Empty value detected")
                self.emptyAlert = true
                return false
            }else{
                print("LBH not empty")
            }
        }else{
            print("Category not wood:",itCategory)
        }
        
        
        if !handler.checkItemExist(itemName: itName){
            
            var priceValue: Double = Double(itPrice) ?? -99
            
            /*
             if itCategory != "None" && (itCategory != itName){
             //Items under category
             //Price should kept 0
             priceValue = 0
             }
             else if itCategory == "None"{
             if priceValue == -99{
             priceValue = 0
             }
             }
             */
            
            if priceValue == -99 || priceValue < 0{
                priceValue = 0
            }
            let l: Double = Double (self.length) ?? 0
            let b: Double = Double (self.breadth) ?? 0
            let h: Double = Double (self.height) ?? 0
            
            print("l",l)
            print("b",b)
            print("h",h)
            print("price",priceValue)
            
            
            if self.selectedCategory != "None"{
                let categoryItem: Item = handler.getItemByName(itemName: self.selectedCategory)
                
                if self.containsDimentions(itCategory: self.selectedCategory){
                    let categoryItem: Item = handler.getItemByName(itemName: self.selectedCategory)
                    let pricePerCube = categoryItem.price
                    if priceValue == 0{
                        priceValue = pricePerCube * l * b/12 * h/12
                    }
                }else{
                    if priceValue == 0 {
                        priceValue = categoryItem.price
                    }
                }
                let temp = Item(id: 1, name: itName, cover: "", price: priceValue, category: itCategory, unit: categoryItem.unit, selected: false, count: 0, subItems: [], dimension: [l, b , h])
                handler.AddItemInDb(itemData: temp)
                return true
            }
            
            let temp = Item(id: 1, name: itName, cover: "", price: priceValue, category: itCategory, unit: itUnit, selected: false, count: 0, subItems: [], dimension: [l, b , h])
            handler.AddItemInDb(itemData: temp)
            return true
        }
        return false
    }
    
    
}

/*
 struct EachItemView_Previews: PreviewProvider {
 static var previews: some View {
 EachItemView()
 }
 }
 */
struct EachCategoryView: View {
    @Binding var EditMenu: Bool
    @Binding var addCategoryMenu: Bool
    @Binding var allUnit: [String]
    @State var name: String = ""
    @State var price: String = "0"
    @State var showAlert = false
    @State var emptyAlert = false
    @State var needDimention = false
    
    @State var length: String = "0"
    @State var breadth: String = "0"
    @State var width: String = "0"
    
    @State var selectedUnit: String = "None"
    
    var body: some View {
        VStack{
            
            HStack{
                
                Text("Category: ")
                    .padding()
                    .frame(width: 150)
                    .font(Font.system(size: 15))
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                TextField("", text: $name)
                    
                    .padding()
                    .font(Font.system(size: 15))
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Duplicate entry"))
                    })
            }.padding()
            
            HStack{
                Text("Price: ")
                    .padding()
                    .frame(width: 150)
                    .font(Font.system(size: 15))
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                TextField("", text: $price )
                    .padding()
                    .font(Font.system(size: 15))
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    .alert(isPresented: $emptyAlert, content: {
                        Alert(title: Text("Empty data"))
                    })
            }
            .padding()
            
            HStack{
                Text("Unit: ")
                    .padding()
                    .frame(width: 75)
                    .font(Font.system(size: 13))
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                Picker("", selection: $selectedUnit) {
                    ForEach(self.allUnit, id: \.self) {
                        Text($0)
                            .font(Font.system(size: 13))
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 200, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(hex: "F5F5F5"))
                .cornerRadius(16)
                .shadow(color: .gray, radius: 2, x: 2, y: 3)
                Section {
                    Text("Dimention: ")
                        .padding()
                        .frame(width: 100)
                        .font(Font.system(size: 13))
                        .background(Color(hex: "F5F5F5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    Toggle("",isOn: $needDimention)
                        //.padding()
                        .font(Font.system(size: 13))
                        .background(Color(hex: "F5F5F5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                }
            }.padding()
            
            /*
             if self.needDimention {
             
             HStack{
             TextField("New Item", text: $length)
             .alert(isPresented: $showAlert, content: {
             Alert(title: Text("Invalid Data"))
             })
             TextField("New Item", text: $breadth)
             .alert(isPresented: $showAlert, content: {
             Alert(title: Text("Invalid Data"))
             })
             TextField("New Item", text: $width)
             .alert(isPresented: $showAlert, content: {
             Alert(title: Text("Invalid Data"))
             })
             }
             }
             */
            HStack{
                Button(action: {
                    self.addCategoryMenu = false
                    self.EditMenu = true
                }, label: {
                    Text("Back")
                    
                }).buttonStyle(BlueButton())
                Button(action: {
                    var res = false
                    if self.needDimention{
                        res = self.addNewCategoryItemWithDImention(itName: self.name, itPrice: self.price, itUnit: self.selectedUnit, itL: self.length, itB: self.breadth, itW: self.width)
                    }else{
                        res = self.addNewCategoryItem(itName: self.name, itPrice: self.price, itUnit: self.selectedUnit)
                    }
                    
                    if res {
                        print("Added ", res)
                    }else{
                        print("Added Failed ",res)
                    }
                    /*
                     let added = addCategoryToDB(item: self.name)
                     if added {
                     self.showListView = true
                     self.showAddItem = false
                     self.showAddCategory = false
                     self.showEditItem = false
                     }
                     */
                    self.addCategoryMenu = false
                    self.EditMenu = true
                }, label: {
                    Text("Add")
                    
                }).buttonStyle(BlueButton())
            }.padding()
            //*/
        }.padding()
        
    }
    func addNewCategoryItem(itName: String, itPrice: String, itUnit: String) -> Bool {
        if (itName.isEmpty || itPrice.isEmpty){
            return false
        }
        let handler = ModelViewHandler()
        if !handler.checkItemExist(itemName: itName){
            
            let priceValue: Double = Double(itPrice) ?? -99
            if priceValue == -99 {
                return false
            }
            handler.AddItemInDb(itemData: Item(id: 1, name: itName, cover: "", price: priceValue, category: itName, unit: itUnit, selected: false, subItems: [], dimension: []))
            return true
        }
        return false
    }
    
    func addNewCategoryItemWithDImention(itName: String, itPrice: String, itUnit: String, itL: String, itB: String, itW: String) -> Bool {
        
        if itName.isEmpty{
            self.showAlert = true
            return false
        }
        let handler = ModelViewHandler()
        if !handler.checkItemExist(itemName: itName){
            
            let priceValue: Double = Double(itPrice) ?? -99
            if priceValue == -99 {
                return false
            }
            
            let lengthValue: Double = Double(itL) ?? -99
            let breadthValue: Double = Double(itB) ?? -99
            let widthValue: Double = Double(itW) ?? -99
            if (lengthValue == -99 || breadthValue == -99 || widthValue == -99){
                return false
            }
            
            
            
            var valuesDimention: [Double] =  []
            valuesDimention.append(lengthValue)
            valuesDimention.append(breadthValue)
            valuesDimention.append(widthValue)
            if !self.needDimention {
                let temp: Item = Item(id: 0, name: itName, cover: "", price: priceValue, category: itName, unit: itUnit, selected: false, count: 0, subItems: [], dimension: [])
                handler.AddItemInDb(itemData: temp)
            }else{
                let temp: Item = Item(id: 0, name: itName, cover: "", price: priceValue, category: itName, unit: itUnit, selected: false, count: 0, subItems: [], dimension: valuesDimention)
                handler.AddItemInDb(itemData: temp)
            }
            
            return true
        }
        return false
    }
}
