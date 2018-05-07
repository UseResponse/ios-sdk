//
//  ChatMessagesQuery.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

@objc public class ChatMessagesQuery: NSObject {
    public var id : Int!
    public var page : Int!
    
    public init(chatId: Int?, page: Int?) {
        self.id = chatId ?? 0
        self.page = page ?? 1
    }
}
