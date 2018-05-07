//
//  FileForm.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class FileForm: NSObject {
    open let name : String!
    open let content : String!
    
    public init(name: String, content: String) {
        self.name = name
        self.content = content
    }
    
    open func dictionaryFromFileForm() -> [String : String] {
        return ["name" : name, "content" : content]
    }
}
