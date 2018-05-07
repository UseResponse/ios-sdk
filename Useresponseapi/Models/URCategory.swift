//
//  URCategory.swift
//  Useresponseapi
//
//  Created by Анна on 09.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class URCategory: NSObject {
    
    public let id: Int
    public let ownership: String
    public let type: String
    public let name: String
    public let slug: String
    
    public init(dictionary: [String : Any]) {
        self.id = dictionary["id"] as! Int
        self.ownership = dictionary["ownership"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.name = dictionary["name"] as! String
        self.slug = dictionary["slug"] as! String
    }
    
    public func getDictionaryFromCategory() -> [String : Any?] {
        return ["id" : self.id, "name" : self.name, "slug" : self.slug, "type" : self.type]
    }
}
