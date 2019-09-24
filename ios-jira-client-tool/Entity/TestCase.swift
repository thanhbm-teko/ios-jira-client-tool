//
//  TestCase.swift
//  ios-jira-client-tool
//
//  Created by Tung N. on 9/23/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

class TestCase {
    var duration: String?
    var name: String?
    var identifier: String?
    var status: String?
    
    init(name: String?, duration: String?, identifier: String?, status: String?) {
        self.name = name
        self.duration = duration
        self.identifier = identifier
        self.status = status
    }
}
