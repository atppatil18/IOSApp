//
//  CalculateView.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/19/21.
//

import SwiftUI

struct CalculateView: View {
    @Binding var authMenu: Bool
    @Binding var CalculateMenu: Bool
    @Binding var EditMenu:Bool
    //@Binding var SelectedArray: [Item]
    var selectItems = [Item]()
    @State var searchText = ""
    var body: some View {
        ZStack{
            //Color(hex: "e9ecef").ignoresSafeArea(.all)
            VStack{

                SearchBar(text: $searchText)
                
                List(selectItems.filter({searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())}),
                     id: \.id){eachItem in
                    
                    HStack{
                        Text(eachItem.name)
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                        Spacer()
                        
                    }
                    .padding()
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(hex: 0x474747))
                    .cornerRadius(10)
                    
                    
                }
                
                
                
                Text("Total Price: \(self.calculatePrice(itemCounts: selectItems))")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                HStack{
                    Button(action: {
                        self.authMenu = true
                        self.CalculateMenu = false
                    }, label: {
                        Text("Back")
                    }).buttonStyle(BlueButton())
                    
                    Button(action: {
                        self.CalculateMenu = false
                        self.EditMenu = true
                        
                    }, label: {
                        Text("Next")
                    }).buttonStyle(BlueButton())
                    
                }
                
                
            }
        }
    }
    func calculatePrice(itemCounts: [Item]) -> String {
        var total: Double = 0
        for eachItem in itemCounts{
            let myInt2 = Double(eachItem.count ?? 1) ?? 0
            total = total + (eachItem.price * myInt2)
        }
        return String(total)
    }
}
/*
 struct CalculateView_Previews: PreviewProvider {
 static var previews: some View {
 CalculateView(authMenu: false, CalculateMenu: true, EditMenu: false)
 }
 }
 */
