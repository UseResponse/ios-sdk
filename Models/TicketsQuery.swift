//
//  TicketsQuery.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class TicketsQuery : NSObject {
    open let page : Int
    open var search : String? {
        willSet {
            self.search = newValue ?? ""
        }
    }
    
    public init(dictionary: [String : Any]) {
        self.page = dictionary["page"] as? Int  ?? 1
        self.search = dictionary["search"] as? String
    }
   
}
