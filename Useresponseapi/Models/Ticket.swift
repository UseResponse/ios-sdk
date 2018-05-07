//
//  Ticket.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class Ticket: NSObject {
    open let id : Int
    open let title : String
    open let content : String?
    open let url : String
    open let createdAt : Int
    open var latestActivity : Int? {
        willSet {
            if newValue == 0 {
                self.latestActivity = self.createdAt
            }
        }
    }
    open let author : User
    open let responsible : User?
    open let status : Status!
    
    open var files = [File]()
    
    open var messages : [Message] {
        return []
    }
    
    init(object: NSDictionary) {
        self.id = object.object(forKey: "id") as! Int
        self.title = object.object(forKey: "title") as! String
        self.content = object.object(forKey: "content") as? String ?? ""
        self.url = object.object(forKey: "url") as! String
        self.createdAt = object.object(forKey: "createdAtPosix") as! Int
        self.latestActivity = object.object(forKey: "latestActivityPosix") as? Int ?? 0
        self.author = User.init(dictionary: object.object(forKey: "author") as! [String : Any])
        if let responsibleValue = object.object(forKey: "responsible") as? NSDictionary {
            self.responsible = User.init(dictionary: responsibleValue as! [String : Any])
        } else {
            self.responsible = nil
        }
        self.status = Status.init(dictionary: object.object(forKey: "status") as! [String : Any])
        
        if object.object(forKey: "attachments") != nil {
            let responseFiles = object.object(forKey: "attachments") as! NSArray
            
            for file in responseFiles {
                self.files.append(File.init(dictionary: file as! [String : Any]))
            }
        }
        
    }
}
