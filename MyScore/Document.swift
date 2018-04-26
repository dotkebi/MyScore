//
//  Document.swift
//  MyScore
//
//  Created by dotkebi on 2018. 4. 26..
//  Copyright © 2018년 dotkebi. All rights reserved.
//

import UIKit

class Document: UIDocument {

    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }

    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}

