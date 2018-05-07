//
//  IdentityData.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class IdentityData: NSObject {
    open let token : String!
    open var email : String!
    open var id : String = ""
    open var firstName : String = ""
    open var lastName : String = ""
    open var properties = [Int : String]()
    
    public init(token: String, email: String) {
        self.token = token
        self.email = email
    }
    
    open func fullName() -> String {
        return "\(firstName) \(lastName)"
    }

    open func dictionaryFromIdentityData() -> [String : Any] {
        var response = ["name" : fullName(), "email" : email, "sso_id" : id] as [String : Any]
    
        var propertyRequest = [String : String]()
        
        for (key, value) in properties {
            propertyRequest["property_\(key)"] = value
        }
        
        if propertyRequest.count > 0 {
            response["properties"] = propertyRequest
        }
        return response
    }
}
