//
//  Chat.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

@objc public class Chat: NSObject {
    public let id : Int!
    public let createdAt : Int!
    public let updatedAt : Int!
    public let completedAt : Bool!
    public let author : User!
    public let responsible : User?
    public let lastMessage : ChatMessage?
    public let seenByClient : Bool!
    
    public init(dictionary: [String : Any]) {
        self.id = dictionary["externalId"] as! Int
        self.createdAt = dictionary["createdAtPosix"] as! Int
        self.updatedAt = dictionary["updatedAtPosix"] as? Int ?? dictionary["createdAtPosix"] as! Int
        self.completedAt = (dictionary["completedAtPosix"] != nil) ? ((dictionary["completedAtPosix"] as! Int) > 0) : false
        self.author = User.init(dictionary: dictionary["author"] as! [String : Any])
        self.responsible = (dictionary["responsible"] != nil && !((dictionary["responsible"]! as AnyObject).isKind(of: NSNull.self))) ? User.init(dictionary: dictionary["responsible"] as! [String : Any]) : nil
        self.lastMessage = (dictionary["lastMessage"] != nil) ? ChatMessage.init(dictionary: dictionary["lastMessage"] as! [String : Any]) : nil
        self.seenByClient = (dictionary["seenByClient"] != nil)
    }
}
