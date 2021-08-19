//
//  Holders.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/18/21.
//

import SwiftUI

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
    
    var dimension: [Double]?
    
}

struct ItemRow: View {
    var isSelected: Bool
    var item: Item
    //@State var isOn = false
    @State var count = ""
    var action: () -> Void
    var showPrice: Bool
    var body: some View{
        //Button(action: self.action){
        
        HStack{
            Text(item.name)
                .font(.title3)
                .foregroundColor(.white)
            
            Text(item.unit ?? "Unit")
                //.font(.title)
                .foregroundColor(.gray)
            Spacer()
            
            //Toggle("",isOn: $isSelected)
            if self.isSelected{
                Image(systemName: "checkmark")
                    .padding(.all, 4)
                    .foregroundColor(.white)
            }
            if self.showPrice{
                //if item.name.lowercased() != item.category.lowercased(){
                    Text(String(format: "%.2f",item.price))
                        .foregroundColor(.white)
                //}
            }
        }
        .padding()
        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(hex: 0x474747))
        .cornerRadius(10)
        //.padding(.horizontal, 3)
        
        // }
    }
}
