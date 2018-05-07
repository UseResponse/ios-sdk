//
//  ChatMessage.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

@objc public class ChatMessage: NSObject {
    public let id : Int!
    public let type : String!
    public let content : String!
    public let createdAt : Int!
    public let author : User!
    public let isSystem : Bool!
    public let token : String!
    
    public init(dictionary: [String : Any]) {
        self.id = dictionary["id"] as! Int
        self.type = dictionary["type"] as! String
        self.content = dictionary["content"] as! String
        self.createdAt = dictionary["createdAtPosix"] as! Int
        self.author = User.init(dictionary: dictionary["author"] as! [String : Any])
        self.isSystem = dictionary["isSystem"] as! Bool
        self.token = dictionary["token"] as! String
    }
    
    public init(content: String, nameUser: String?) {
        self.id = 0
        self.type = ""
        self.content = content
        self.createdAt = 0
        self.author = User.init(nameUser: nameUser)
        self.isSystem = false
        self.token = ""
    }
}
