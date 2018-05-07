//
//  Comment.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class Comment: NSObject {
    open let id : Int
    open let content : String
    open let createdAt : Int
    open let author : User
    open var files = [File]()
    
    public init(dictionary: [String : Any]) {
        self.id = dictionary["id"] as! Int
        self.content = (dictionary["content"] as? String) ?? ""
        self.createdAt = dictionary["createdAtPosix"] as! Int
        self.author = User.init(dictionary: dictionary["author"] as! [String : Any])
        
        if dictionary["attachments"] != nil {
            let attachments = dictionary["attachments"] as! [Any]
            for attachment in attachments {
                self.files.append(File.init(dictionary: attachment as! [String : Any]))
            }
        }
    }
}
