//
//  SearchBar.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/18/21.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        ZStack{
            
            HStack{
                TextField("Search ...", text: $text)
                    .padding(7)
                    .frame(height: 40)
                    .font(Font.system(size: 20, design: .rounded))
                    .padding(.horizontal, 25)
                    .background(Color(hex: "F5F5F5"))
                    .cornerRadius(16)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )//.padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                        
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
                
            }.padding()
        }.background(Color(hex: "ffffff"))
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}

