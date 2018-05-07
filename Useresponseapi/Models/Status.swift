//
//  Status.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class Status: NSObject {
    open let id : Int!
    open let title : String!
    open let slug : String!
    open let isDefault : Bool!
    open let isClosed : Bool!
    open let backgroundColor : String!
    open let textColor : String!
    
    public init(dictionary: [String : Any]) {
        self.id = dictionary["id"] as! Int
        self.title = dictionary["title"] as! String
        self.slug = dictionary["slug"] as! String
        self.isDefault = dictionary["isDefault"] as! Bool
        self.isClosed = dictionary["isClosed"] as! Bool
        let color = dictionary["color"] as! [String : String]
        self.backgroundColor = color["background"]
        self.textColor = color["text"]
    }
}
