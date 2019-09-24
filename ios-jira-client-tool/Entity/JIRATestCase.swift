//
//  JIRATestCase.swift
//  ios-jira-client-tool
//
//  Created by Tung Nguyen on 9/24/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

class JIRATestCase: Codable {
    var key: String?
    var status: String?
    var issueLinks: [String]?
    var projectKey: String?
}
