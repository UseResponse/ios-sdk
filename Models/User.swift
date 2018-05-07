//
//  User.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

@objc public class User: NSObject {
    public let id : Int!
    public let name : String!
    public let shortName : String!
    public let apiKey : String!
    public let email : String!
    public let avatar : Avatar!

    public init(dictionary: [String : Any]) {
        self.id = dictionary["id"] as! Int
        self.name = dictionary["name"] as! String
        self.shortName = dictionary["shortName"] as! String
        self.apiKey = dictionary["apiKey"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.avatar = Avatar.init(dictionary: dictionary["avatar"] as! [String : String])
    }
    
    public init(nameUser: String?) {
        self.id = 0
        self.name = nameUser ?? "Guest"
        self.shortName = ""
        self.apiKey = ""
        self.email = ""
        self.avatar = Avatar.init()
        
    }
}
