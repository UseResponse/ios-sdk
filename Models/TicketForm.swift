//
//  TicketForm.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class TicketForm: NSObject {
    var properties = [String : String]()
    
    public init(title: String?, content: String?, field : [String : String]?) {
        if title != nil {
            self.properties["title"] = title!
        }
        if content != nil {
            self.properties["content"] = content!
        }
        if field != nil {
            for (key, value) in field! {
                self.properties[key] = value
            }
        }
    }
    
    func getDictionaryFromTicket() -> [String : String]? {
        var result = ["ownership" : "helpdesk", "object_type" : "ticket"]
        for (key, value) in properties {
            result[key] = value
        }
        return result
    }
}
