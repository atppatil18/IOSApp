//
//  UpdateItemView.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/20/21.
//

import SwiftUI

struct UpdateItemView: View {
    
    @Binding var update_price: String
    @Binding var update_Item: Item    
    @Binding var EditMenu: Bool
    @Binding var updateItemMenu: Bool
    @Binding var update_dimention: [String]
    //var update_name: String = ""
    var update_price_temp: String = ""
    //var update_category: String = ""
    
    @State var updateAlert: Bool = false
    @State var failedupdateAlert: Bool = false
    
    
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("Name: ")
                        .frame(width: 100, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .font(Font.system(size: 16, design: .rounded))
                        .background(Color(hex: "f5f5f5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                        .padding()
                    
                    Text(self.update_Item.name)
                        .frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .font(Font.system(size: 16, design: .rounded))
                        .background(Color(hex: "f5f5f5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                        .padding()
                    
                    Spacer()
                }.padding()
                HStack{
                    Text("Price: ")
                        .frame(width: 100, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .font(Font.system(size: 16, design: .rounded))
                        .background(Color(hex: "f5f5f5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                        .padding()
                    TextField("", text: self.$update_price)
                        .frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .font(Font.system(size: 16, design: .rounded))
                        .alert(isPresented: $failedupdateAlert, content: {
                            Alert(title: Text("Data updated failed"))
                        })
                        .background(Color(hex: "f5f5f5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                        .padding()
                    Spacer()
                }.padding()
                
                if !self.update_dimention.isEmpty {
                    if ((update_dimention[0] != "0.00" && update_dimention[1] != "0.00"  && update_dimention[2] != "0.00" ) && (update_dimention[0] != "999.00" && update_dimention[1] != "999.00"  && update_dimention[2] != "999.00" ) ){
                        HStack{
                            Text("Length: ")
                                .padding()
                            Text(self.update_dimention[0])
                                .padding()
                            Spacer()
                        }.padding()
                        HStack{
                            Text("Width: ")
                                .padding()
                            Text(self.update_dimention[1])
                                .padding()
                            Spacer()
                        }.padding()
                        HStack{
                            Text("Height: ")
                                .padding()
                            Text(self.update_dimention[2])
                                .padding()
                            Spacer()
                        }.padding()
                    }
                    
                    
                }
                
                HStack{
                    Spacer()
                    Button(action: {
                        
                        if(updateItem(oldNameData: self.update_Item.name, item: self.update_Item, price: self.update_price)){
                            updateAlert = true
                        }else{
                            failedupdateAlert = true
                            
                        }
                        
                        self.updateItemMenu = false
                        self.EditMenu = true
                        
                        
                    }, label: {
                        Text("Update")
                        
                    }).buttonStyle(BlueButton())
                    
                    Button(action: {
                        ///*
                        if(deleteItem(name: self.update_Item.name)){
                            updateAlert = true
                        }else{
                            failedupdateAlert = true
                            
                        }
                        
                        self.updateItemMenu = false
                        self.EditMenu = true
                    }, label: {
                        Text("Delete")
                        
                    }).buttonStyle(BlueButton())
                    Spacer()
                }.padding()
                
                
                
                
                
            }
        }
        
    }
    
    
    func updateItem(oldNameData: String, item: Item, price: String) -> Bool {
        //print("Update Price "+oldNameData+" -> Price "+price)
        if(oldNameData.isEmpty || price.isEmpty){
            return false
        }
        //print("Updating Price")
        let temp: Double = Double(price) ?? 0
        if temp != item.price {
            ModelViewHandler().updateItem(name: item.name, price: temp)
        }
        return true
        //return ModelViewHandler().updateItem(name: oldNameData, price: price)
        //sreturn RealmHandler().updateItemDatainDB(oldName: oldNameData, newName: name, newPrice: oldPrice)
        
    }
    
    func deleteItem(name: String) -> Bool {
        ModelViewHandler().deleteItemObject(name: name)
        return true
        // return RealmHandler().deleteItemFromDB(Name: name)
    }
    
}

/*
 struct UpdateItemView_Previews: PreviewProvider {
 static var previews: some View {
 UpdateItemView()
 }
 }
 */
