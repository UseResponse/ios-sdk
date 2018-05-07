//
//  ChatMessages.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

public class ChatMessages: NSObject {
    
    public var chats = [Chat]()
    public var chatMessages = [ChatMessage]()
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
            let chatMessagesResponse = dictionary["data"] as! NSArray
            for chatMsg in chatMessagesResponse {
                self.chatMessages.append(ChatMessage.init(dictionary: chatMsg as! [String : Any]))
            }
        }
    }
}
