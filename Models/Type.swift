//
//  Type.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

public class Type: NSObject {
    private var typeSlug = String()
    private var typeTitle = String()
    
    class public func add(object: NSDictionary) -> Type {
        let type = Type()
        type.typeSlug = object.object(forKey: "slug") as! String
        type.typeTitle = (object.object(forKey: "title") as! NSDictionary).object(forKey: "plural") as! String
        
        return type
    }
    
    public func slug() -> String {
        return typeSlug
    }
    
    public func title() -> String {
        return typeTitle
    }
}

