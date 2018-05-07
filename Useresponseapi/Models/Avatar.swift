//
//  Avatar.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

public class Avatar: NSObject {
    public let tiny : String!
    public let small : String!
    public let medium : String!
    public let big : String!
    
    public init(dictionary: [String : String]) {
        self.tiny = dictionary["tiny"]
        self.small = dictionary["small"]
        self.medium = dictionary["medium"]
        self.big = dictionary["big"]
    }
    
    public override init() {
        self.tiny = ""
        self.small = ""
        self.medium = ""
        self.big = ""
    }
}
