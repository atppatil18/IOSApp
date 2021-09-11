//
//  CustomFileHandler.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 9/2/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct TextFile: FileDocument {
    
    static var readableContentTypes =  [UTType.plainText]
    var text = ""
    var url : String

    init(URL: String){
        self.url = URL
    }

    init(configuration: ReadConfiguration) throws {
        url = ""
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let file = try! FileWrapper(url: URL(fileURLWithPath: url), options: .immediate)
        return file
    }
}

struct CustomFileHandler: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CustomFileHandler_Previews: PreviewProvider {
    static var previews: some View {
        CustomFileHandler()
    }
}
