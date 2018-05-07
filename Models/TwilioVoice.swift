//
//  TwilioVoice.swift
//  Useresponseapi
//
//  Created by Анна on 02.04.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

@objc public class TwilioVoice: NSObject {
    private var identityVoice: String?
    private var identityToken: String?
    
    @objc public class func twilioVoice(object: NSDictionary) -> TwilioVoice {
        let twilio = TwilioVoice()
        twilio.identityVoice = object.object(forKey: "identity") as? String
        twilio.identityToken = object.object(forKey: "token") as? String
        
        return twilio
    }
    
    @objc public func identity() -> String? {
        return identityVoice ?? ""
    }
    
    @objc public func token() -> String? {
        return identityToken ?? ""
    }
}
