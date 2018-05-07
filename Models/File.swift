//
//  File.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class File: NSObject {
    open let id : Int!
    open let name : String!
    open var ext : String!
    open let url : String!
    
    public init(dictionary : [String : Any]) {
        self.id = dictionary["id"] as! Int
        self.url = dictionary["directUrl"] as! String
        self.name = (dictionary["name"] as! [String : Any])["full"] as! String
        self.ext = (dictionary["name"] as! [String : Any])["ext"] as? String ?? ""
    }
}
