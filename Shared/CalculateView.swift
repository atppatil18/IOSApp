//
//  CalculateView.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 7/19/21.
//

import SwiftUI
//import AppKit

struct CalculateView: View {
    @Binding var authMenu: Bool
    @Binding var CalculateMenu: Bool
    @Binding var EditMenu:Bool
    
    @State  var saveFile = false
    //@Binding var SelectedArray: [Item]
    var selectItems = [Item]()
    @State var searchText = ""
    
    @State var finalStringSave = ""
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
                
                
                //print("PATH ",Bundle.main.path(forResource: "dataFile", ofType: "txt"))
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
                    
                    Button(action: {
                        
                        self.saveFile = true
                        finalStringSave = WriteCSV(itemCounts: selectItems)
                        

                    }, label: {
                        Text("Save")
                    }).buttonStyle(BlueButton())
                    //Bundle.main.path(forResource: "dataFile", ofType: "txt")!
                    //getDirectory().path
                }.fileExporter(isPresented: $saveFile, document: CSVFile(initialText: finalStringSave), contentType: .commaSeparatedText){ result in
                    switch result {
                    case .success(let url):
                        print("Saved to \(url)")
                        self.saveFile = false
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                    }
                }
                /*.fileExporter(isPresented: $saveFile, document: TextFile(URL: Bundle.main.path(forResource: "bill", ofType: "txt")! ),contentType: .plainText) { (res) in
                    do{
                        let fileUrl = try res.get()
                        print(fileUrl)
                    }catch{
                        print("Cannot created file")
                        print(error.localizedDescription)
                    }
                }
 */
                
                
            }
        }
    }
    func calculatePrice(itemCounts: [Item]) -> String {
        var total: Double = 0
        for eachItem in itemCounts{
            let myInt2 = Double(eachItem.cover ?? "1") ?? 0
            
            
            //let myInt2 = Double(eachItem.count ?? 1) ?? 0
            total = total + (eachItem.price * myInt2)
        }
        return String(total)
    }
    
    func WriteCSV(itemCounts: [Item]) -> String{
        var textToWrite: String = "Category, Item, Count, Per Unit,Price"
        var total: Double = 0
        for eachItem in itemCounts{
            
            let myInt2 = Double(eachItem.cover ?? "1") ?? 0
            let rowPrice = eachItem.price * myInt2
            let countString = eachItem.count ?? 0
            textToWrite += "\n"
            textToWrite += eachItem.category //+ ", "+String(myInt2)
            textToWrite += ", "
            textToWrite += eachItem.name //+ ", "+String(myInt2)
            textToWrite += ", "
            textToWrite += eachItem.cover//String(countString)
            textToWrite += ", "
            textToWrite += String(eachItem.price) //+ ", "+String(myInt2)
            textToWrite += ", "
            textToWrite += String(rowPrice)
            
            total = total + (rowPrice)
        }
        textToWrite += "\n"
        textToWrite += "Total"
        textToWrite += ", "
        
        textToWrite += ", "
        textToWrite += String(total)
        
        print(textToWrite)
        return textToWrite
    }
    
    func getDirectory() -> URL {
        
        let paths  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
        
    }
}
/*
 struct CalculateView_Previews: PreviewProvider {
 static var previews: some View {
 CalculateView(authMenu: false, CalculateMenu: true, EditMenu: false)
 }
 }
 */



