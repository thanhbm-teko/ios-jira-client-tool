//
//  TestItem.swift
//  ios-jira-client-tool
//
//  Created by Tung Nguyen on 9/24/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

class TestItem {
    var status: String?
    var testCaseKey: String?
    var executionDate: String?
    
    var dict: [String: String] {
        var dict = [String: String]()
        dict["status"] = status
        dict["testCaseKey"] = testCaseKey
        dict["executionDate"] = executionDate
        return dict
    }
}
