//
//  NeumorphicView.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 8/7/21.
//

import SwiftUI

struct NeumorphicView: View {
    var body: some View {
        VStack {
            Button("Hello, Neumorphism!", action: {
                
            }).padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.neuBackground)
            )
            .shadow(color: .dropShadow, radius: 15, x: 10, y: 10)
            .shadow(color: .dropLight, radius: 15, x: -10, y: -10)
            .foregroundColor(.primary)
        }
    }
}

struct NeumorphicView_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphicView()
    }
}

extension Color {
    static let neuBackground = Color(hex: "f0f0f3")
    static let dropShadow = Color(hex: "aeaec0").opacity(0.4)
    static let dropLight = Color(hex: "ffffff")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
