//
//  CustomFieldOption.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class CustomFieldOption: NSObject {
    open let title : String!
    open let value : String!
    
    public init(dictionary: [String : String]) {
        self.title = dictionary["title"]
        self.value = dictionary["value"]
    }
}
