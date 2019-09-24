//
//  FileUtils.swift
//  ios-jira-client-tool
//
//  Created by Tung N. on 9/24/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

class FileUtils {
    
    class func loadConfig(path: String) -> NSDictionary? {
        return NSDictionary(contentsOfFile: path)
    }
    
}
