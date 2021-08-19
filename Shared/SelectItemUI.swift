//
//  SelectItemUI.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/18/21.
//

import SwiftUI

struct SelectItemUI: View {
    @State var selectMenu: Bool = true
    @State var selectedItemsRow = Set<Item>()
    @State var SelectedArray = [Item]()
    @State var confirmMenu: Bool = false
    @State var authMenu: Bool = false
    @State var CalculateMenu: Bool = false
    @State var EditMenu:Bool = false
    @State var addItemMenu:Bool = false
    @State var addCategoryMenu: Bool = false
    @State var updateItemMenu: Bool = false
    
    
    
    @State var update_name: String = ""
    @State var update_price: String = ""
    @State var update_category: String = ""
    @State var update_item: Item = Item(id: 0, name: "", cover: "", price: 0, category: "", selected: false)
    @State var update_dimention: [String] = ["0","0","0"]
    @State var allUnit = ["None", "/kg","/ft3" , "/ltr","/m","/cm","/ft","/pack"]
    var body: some View {
        
        
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            if self.selectMenu{
                //SelectView(
                SelectView(selectMenu: $selectMenu,selectedItemsRow: $selectedItemsRow, SelectedArray: $SelectedArray, confirmMenu: $confirmMenu)
            }else if self.confirmMenu{
                ConfirmView(selectMenu: $selectMenu ,confirmMenu: $confirmMenu, SelectedArray: $SelectedArray, authMenu: $authMenu)
            }else if self.authMenu{
                AuthView(confirmMenu: $confirmMenu, authMenu: $authMenu, CalculateMenu: $CalculateMenu)
            }else if self.CalculateMenu{
                CalculateView(authMenu: $authMenu, CalculateMenu: $CalculateMenu, EditMenu: $EditMenu, selectItems: SelectedArray)
            }else if self.EditMenu{
                EditListView(selectMenu: $selectMenu, CalculateMenu: $CalculateMenu, EditMenu: $EditMenu, addItemMenu: $addItemMenu, addCategoryMenu: $addCategoryMenu, updateItemMenu: $updateItemMenu, update_name: $update_name, update_price: $update_price, update_category: $update_category, update_Item: $update_item, update_dimention: $update_dimention)
                
            }else if self.addItemMenu{
                //EachItemView(EditMenu: $EditMenu, addItemMenu: $addItemMenu)
                EachItemView(EditMenu: $EditMenu, addItemMenu: $addItemMenu, allUnit: $allUnit)
            }else if self.addCategoryMenu{
                EachCategoryView(EditMenu: $EditMenu, addCategoryMenu: $addCategoryMenu, allUnit: $allUnit)
            }else if self.updateItemMenu{
                //UpdateItemView(update_price: $update_price, update_Item: $update_item, EditMenu: $EditMenu, updateItemMenu: $updateItemMenu)
                UpdateItemView(update_price: $update_price, update_Item: $update_item, EditMenu: $EditMenu, updateItemMenu: $updateItemMenu, update_dimention: $update_dimention)
            }
        }
        
    }
}
struct SelectItemUI_Previews: PreviewProvider {
    static var previews: some View {
        SelectItemUI()
    }
}


struct SelectView: View {
    @Binding var selectMenu: Bool
    @Binding var selectedItemsRow: Set<Item>
    @Binding var SelectedArray: [Item]
    @Binding var confirmMenu: Bool
    var viewHandler = ModelViewHandler()
    @State var selectedItem: [String] = []
    var allItemList:[Item] = ModelViewHandler().getAllItems()
    @State var searchText = ""
    @State var sel = false
    /*
     init() {
     selectedItem = self.syncArray(existingArray: SelectedArray)
     }
     */
    var body: some View{
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack{
                if allItemList.count == 0 {
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("No Items found in Database")
                                .foregroundColor(Color(hex: "002855"))
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    
                }else{
                    VStack{
                        //self.selectedItem = syncArray(existingArray: self.SelectedArray)
                        SearchBar(text: $searchText)
                        List(allItemList.filter({searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())}),
                             id: \.id, children: \.subItems){ eachitem in
                            
                            ItemRow(isSelected: self.selectedItem.contains(eachitem.name), item: eachitem, action: {}, showPrice: false).onTapGesture {
                                
                                //if self.SelectedArray.contains(eachitem){
                                
                                //}
                                
                                if eachitem.name.lowercased() != eachitem.category.lowercased(){
                                    
                                    if let index = self.selectedItem.firstIndex(of: eachitem.name){
                                        self.selectedItemsRow.remove(eachitem)
                                        self.selectedItem.remove(at: index)
                                        
                                    }else{
                                        self.selectedItem.append(eachitem.name)
                                        self.selectedItemsRow.insert(eachitem)
                                        //selectedItems(pick: eachitem, isTick: false)
                                    }
                                }
                            }
                        }
                    }//VStack
                    
                }//Else
                
                
                Button(action: {
                    self.selectMenu = false
                    self.confirmMenu = true
                    self.SelectedArray = itemsInitialize(itemRows: self.selectedItemsRow)
                    
                }, label: {
                    Text("Confirm")
                        .bold()
                    
                }
                )
                .buttonStyle(BlueButton())
                
            }//VStack
        }//ZStack
        //.background(Color.gray.edgesIgnoringSafeArea(.all))
    }
    
    func syncArray(existingArray: [Item]) -> [String] {
        var temp: [String] = []
        for each in existingArray {
            
            temp.append(each.name)
        }
        return temp
    }
    
    func itemsInitialize(itemRows: Set<Item>) -> [Item] {
        var tempArr = [Item]()
        for eachItem in itemRows{
            
            let temp =  Item(id: eachItem.id, name: eachItem.name, cover: eachItem.cover, price: eachItem.price, category: eachItem.category, unit: eachItem.unit, selected: eachItem.selected, count: 1)
            
            tempArr.append(temp)
        }
        return tempArr
    }
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width: 100, height: 50, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .background(Color(hex: "002855"))
            .foregroundColor(.white)
                .mask(RoundedRectangle(cornerRadius: 10))
            .padding()
                .shadow(color: .gray, radius: 2, x: 2, y: 3)    
            
        
    }
}

struct TransparentButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(width: 40, height: 40, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .background(Color.white)
        .foregroundColor(.white)
            .mask(RoundedRectangle(cornerRadius: 10))
            //.opacity(0.9)
            .shadow(color: Color(hex: "292929"), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 1, y: 1)
    }
}
struct ConfirmView: View {
    @Binding var selectMenu: Bool
    @Binding var confirmMenu: Bool
    //@Binding var selectedItemsRow: Set<Item>
    @Binding var SelectedArray: [Item]
    @Binding var authMenu: Bool
    @State var searchTextData = ""
    
    var body: some View{
        ZStack{
            //e9ecef
            //Color(hex: "e9ecef").ignoresSafeArea(.all)
            VStack{
                
                SearchBar(text: $searchTextData)
                    
                
                List(SelectedArray.indices , id: \.self){index in
                    
                    
                    HStack{
                        Text(SelectedArray[index].name)
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        Spacer()
                        Text(String(SelectedArray[index].count ?? 0))
                            .frame(width: 40, height: 40, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .background(Color.white)
                            .foregroundColor(.gray)
                                .mask(RoundedRectangle(cornerRadius: 10))
                                //.opacity(0.9)
                                .shadow(color: Color(hex: "292929"), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 1, y: 1)
                            /*
                            .frame(width: 30, height: 30, alignment: .leading)
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
 */
                        Button(action: {
                            let myInt2 = SelectedArray[index].count ?? 0
                            SelectedArray[index].count =  myInt2 + 1
                            
                        }, label: {
                            Image(systemName: "plus")
                                //.background(Color.white)
                                .foregroundColor(.gray)
                        }).buttonStyle(TransparentButton())
                        
                        
                        Button(action: {
                            
                            let myInt2 = SelectedArray[index].count ?? 0
                            if myInt2 > 0{
                                SelectedArray[index].count =  myInt2 - 1
                            }
                        }, label: {
                            Image(systemName: "minus")
                                //.background(Color.white)
                                .foregroundColor(.gray)
                        }).buttonStyle(TransparentButton())
                        
                        
                        
                    }
                    .padding()
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(hex: 0x474747))
                    .cornerRadius(10)
                    
                }//List
                //.background(Color(hex: "e9ecef"))
                
                HStack{
                    
                        
                    Button(action: {
                        self.confirmMenu = false
                        self.selectMenu = true
                    }, label: {
                        Text("Back")
                    })
                    .buttonStyle(BlueButton())
                    
                    Button(action: {
                        self.confirmMenu = false
                        self.authMenu = true
                    }, label: {
                        Text("Next")
                    })
                    .buttonStyle(BlueButton())
                    
                    
                }
            }//VStack
        }//ZStack
        //Text("Confirm Data")
    }
}
