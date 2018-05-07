//
//  ChatQuery.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

@objc public class ChatQuery: NSObject {
    let id : Int!
    
    public init(chatId: Int) {
        self.id = chatId
    }
}

