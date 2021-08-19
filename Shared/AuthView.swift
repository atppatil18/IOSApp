//
//  AuthView.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/19/21.
//

import SwiftUI

struct AuthView: View {
    var selectItems = [Item]()
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var access: Bool = false
    
    @Binding var confirmMenu: Bool
    @Binding var authMenu: Bool
    @Binding var CalculateMenu: Bool
    
    var body: some View {
        
            VStack{
                Spacer()
                HStack{
                    //Image(systemName: "person")
                    //    .foregroundColor(.secondary)
                    TextField("Username", text: $username)
                        
                        .padding(10)
                        .padding(.horizontal, 25)
                        .font(Font.system(size: 20, design: .rounded))
                        .textFieldStyle(PlainTextFieldStyle())
                        .background(Color(hex: "f5f5f5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                        .overlay(
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                
                            }
                        )
                    
                }
                //.padding()
                
                HStack{
                    //Image(systemName: "person")
                    //    .foregroundColor(.secondary)
                    SecureField("Password", text: $password)
                        
                        .padding(10)
                        .padding(.horizontal, 25)
                        .font(Font.system(size: 20, design: .rounded))
                        .textFieldStyle(PlainTextFieldStyle())
                        .background(Color(hex: "f5f5f5"))
                        .cornerRadius(16)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                        .overlay(
                            HStack {
                                Image(systemName: "key")
                                    .foregroundColor(Color(hex: "cccccc"))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                
                            }
                        )
                    
                }
                
                
                HStack{
                    
                    Button(action: {
                        self.confirmMenu = true
                        self.authMenu = false
                    }, label: {
                        Text("Back")
                    }).buttonStyle(BlueButton())
                    
                    Button(action: {
                        if(authCheck(user: self.username, pass: self.password)){
                            self.authMenu = false
                            self.CalculateMenu = true
                        }else{
                            //self.authMenu = false
                            //self.CalculateMenu = true
                        }
                    }, label: {
                        Text("Next")
                    }).buttonStyle(BlueButton())
                    
                    
                }
                Spacer()
            }
            .padding(20)
            
       
        
    }
    func authCheck(user: String, pass: String) -> Bool {
        if(user == "User" && pass == "Password"){
            return true
        }
        else{
            return false
        }
    }
}
/*
 struct AuthView_Previews: PreviewProvider {
 static var previews: some View {
 AuthView(confirmMenu: <#Binding<Bool>#>, authMenu: <#Binding<Bool>#>, CalculateMenu: <#Binding<Bool>#>)//confirmMenu: false, authMenu: true, CalculateMenu: false)
 }
 }
 */
