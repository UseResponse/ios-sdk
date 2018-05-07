//
//  CommentForm.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class CommentForm: NSObject {
    open let id: Int!
    open let content: String?
    
    open var files = [String : String]()
    
    public init(objectId: Int, content: String?) {
        self.id = objectId
        self.content = content
    }
    
    open func attachFile(token: String, name: String) {
        files[token] = name
    }
    
    open func dictionaryFromCommentForm() -> [String : Any] {
        var returnDictionary = ["object_id" : id, "content" : content ?? ""] as [String : Any]
        var attachFiles = [(key: String, value: String)]()
        
        for file in files {
            attachFiles.append(file)
        }
       
        if attachFiles.count > 0 {
            returnDictionary["attachments"] = attachFiles
        }
        return returnDictionary
    }
}
