//
//  Article.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

open class Article: NSObject {
    public let id: Int!
    public let slug: String!
    public let title: String!
    public let content: String!
    public let url: String!
    public let author: User!
    public let type: Type!
    public let category: URCategory!
  
    public init(dictionary: [String : Any]) {
        self.id = dictionary["id"] as! Int
        self.slug = dictionary["slug"] as! String
        self.title = dictionary["title"] as! String
        self.content = dictionary["content"] as! String
        self.url = dictionary["url"] as! String
        self.author = User.init(dictionary: dictionary["author"] as! [String : Any])
        self.type = Type.add(object: dictionary["type"] as! NSDictionary)
        self.category = URCategory.init(dictionary: dictionary["category"] as! [String : Any])
    }
    
    func getDictionaryFromArticle() -> [String : Any] {
        return ["id" : self.id, "type" : self.type.slug(), "slug" : self.slug, "title" : self.title, "content" : self.content, "url" : self.url, "categoryId" : self.category.id]
    }
}
