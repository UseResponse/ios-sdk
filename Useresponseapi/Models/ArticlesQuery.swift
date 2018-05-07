//
//  ArticlesQuery.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

@objc open class ArticlesQuery: NSObject {
    let type : String!
    let category : Int!
    let search : String!
    let featured : Bool!
    let forum : Int!
    
    public init(type: String?, category: Int?, search: String?, featured: Bool?, forum: Int?) {
        self.type = type ?? ""
        self.category = category ?? -1
        self.search = search ?? ""
        self.featured = featured ?? false
        self.forum = forum ?? 0
    }
    
    public convenience init(type: String!) {
        self.init(type: type, category: nil, search: nil, featured: nil, forum: nil)
    }
    
    public convenience init(category: Int!) {
        self.init(type: nil, category: category, search: nil, featured: nil, forum: nil)
    }
    
    public convenience init(search: String!) {
        self.init(type: nil, category: nil, search: search, featured: nil, forum: nil)
    }
    
    public convenience init(featured: Bool!) {
        self.init(type: nil, category: nil, search: nil, featured: featured, forum: nil)
    }
    
    public convenience init(forum: Int!) {
        self.init(type: nil, category: nil, search: nil, featured: nil, forum: forum)
    }
    
    public convenience override init() {
        self.init(type: nil, category: nil, search: nil, featured: nil, forum: nil)
    }
}
