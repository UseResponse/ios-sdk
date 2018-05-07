//
//  CustomField.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class CustomField: NSObject {
    open let id : Int!
    open let slug : String!
    open let type : String!
    open let title : String!
    open let descriptionField : String!
    open let isPrivate : Bool!
    open let isRequired : Bool!
    open var options = [CustomFieldOption]()
    
    public init(dictionary: [String : Any]) {
        self.id = dictionary["id"] as! Int
        self.slug = dictionary["slug"] as! String
        self.type = dictionary["type"] as! String
        self.title = dictionary["title"] as! String
        self.descriptionField = dictionary["description"] as? String ?? ""
        self.isPrivate = dictionary["is_private"] as! Bool
        self.isRequired = dictionary["is_required"] as! Bool
        
        if dictionary["options"] != nil {
            let options = dictionary["options"] as! NSArray
            for option in options {
                self.options.append(CustomFieldOption.init(dictionary: option as! [String : String]))
            }
        }
    }
}
