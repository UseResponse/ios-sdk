//
//  Chats.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

@objc public class Chats: NSObject {
    
    public var chats = [Chat]()
    public var totalObjects = 0
    public var objectsPerPage = 0
    public var totalPages = 0
    public var currentPage = 1
    
    public init(dictionary: [String : Any]) {
        self.totalObjects = dictionary["totalObjects"] as! Int
        self.objectsPerPage = dictionary["objectsPerPage"] as! Int
        self.totalPages = dictionary["totalPages"] as! Int
        self.currentPage = dictionary["currentPage"] as! Int
        if dictionary["data"] != nil {
            let chatsResponse = dictionary["data"] as! NSArray
            for chat in chatsResponse {
                chats.append(Chat.init(dictionary: chat as! [String : Any]))
            }
        }
    }
}
