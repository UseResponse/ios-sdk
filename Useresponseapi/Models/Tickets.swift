//
//  Tickets.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class Tickets: NSObject {
    open let totalObjects: Int
    open let objectsPerPage: Int
    open let totalPages: Int
    open let currentPage: Int
    open var tickets = [Ticket]()
    
    public init(object: NSDictionary) {
        self.totalObjects = object.object(forKey: "totalObjects") as! Int
        self.objectsPerPage = object.object(forKey: "objectsPerPage") as! Int
        self.totalPages = object.object(forKey: "totalPages") as! Int
        self.currentPage = object.object(forKey: "currentPage") as! Int
        
        if object.object(forKey: "data") != nil {
            let response = object.object(forKey: "data") as! NSArray
            
            for ticket in response {
                self.tickets.append(Ticket(object: ticket as! NSDictionary))
            }
        }
    }
}
