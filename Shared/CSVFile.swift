//
//  CSVFile.swift
//  Poonam Sofas
//
//  Created by Atul Patil on 9/10/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct CSVFile: FileDocument {

    static var readableContentTypes =  [UTType.commaSeparatedText]
    //static var readableContentTypes: [UTType.]

    @State var text:String// = ""
    init(initialText: String = "" ) {
        text = initialText
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents{
            text  = String(decoding: data, as: UTF8.self)
        }else{
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
