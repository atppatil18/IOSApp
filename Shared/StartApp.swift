//
//  StartApp.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/18/21.
//

import SwiftUI

struct StartApp: View {
    @State var welcomeScreen: Bool = true
    @State var SelectItemScreen: Bool = false
    var body: some View {
        NavigationView{
            WelcomeScreen(welcomeScreen: $welcomeScreen, SelectItemScreen: $SelectItemScreen)
        }
        
    }
}

struct StartApp_Previews: PreviewProvider {
    static var previews: some View {
        StartApp()
    }
}

struct WelcomeScreen: View{
    @Binding var welcomeScreen: Bool
    @Binding var SelectItemScreen: Bool
    var body: some View{
       
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0xF39C91), Color(hex: 0xffffff)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            //Color(hex:0xa4c3b2)
            VStack{
                Text("Welcome")
                    .foregroundColor(.white)
                
                Image("Logo")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .leading)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
                    .padding(100)
                
                NavigationLink(destination: SelectItemUI()){
                    Text("Start")
                        //.frame(width: 100, height: 50, alignment: .center)
                        //.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        //.background(Color(hex: "002855"))
                        //.foregroundColor(.white)
                            //.mask(RoundedRectangle(cornerRadius: 10))
                        //.padding()
                            //.shadow(color: .gray, radius: 2, x: 2, y: 3)
                }
      
                
            }.padding()
            
        }
        
    }
}
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
