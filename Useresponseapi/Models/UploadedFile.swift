//
//  UploadedFile.swift
//  RequestsUseresponseui
//
//  Created by Анна on 06.03.18.
//  Copyright © 2018 ad. All rights reserved.
//

import UIKit

@objc public class UploadedFile: NSObject {
    private var tokenFile = String()
    private var urlFile = String()
    
    @objc class public func add(file: NSDictionary) -> UploadedFile {
        let uploadedFile = UploadedFile()
        uploadedFile.tokenFile = file.object(forKey: "token") as! String
        uploadedFile.urlFile = file.object(forKey: "url") as! String
        return uploadedFile
    }
    
    @objc public func token() -> String {
        return tokenFile
    }
    
    @objc public func url() -> String {
        return urlFile
    }
}


