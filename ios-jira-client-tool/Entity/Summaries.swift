//
//  Summaries.swift
//  ios-jira-client-tool
//
//  Created by Tung N. on 9/23/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

class TestSummaries: Codable {
    
    let type: TypeValue?
    let summaries: Summaries?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case summaries
    }
    
}

class Summaries: Codable {
    
    let type: TypeValue?
    let values: [SummariesValue]?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
    
}

class SummariesValue: Codable {
    let type: TypeValue?
    let name: NameValue?
    let testableSummaries: TestableSummaries?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case name
        case testableSummaries
    }
    
}

class TestableSummaries: Codable {
    let type: TypeValue?
    let values: [TestableSummariesValue]?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
}

class TestableSummariesValue: Codable {
    var type: TypeValue?
    var name: NameValue?
    var tests: Tests?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case name
        case tests
    }
    
}

class Tests: Codable {
    let type: TypeValue?
    let values: [TestsValues]?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }

    var testCases: [TestCase] {
        var cases = [TestCase]()
        values?.forEach({ testValue in
            if let testCases = testValue.testCases {
                cases.append(contentsOf: testCases)
            }
        })
        return cases
    }
    
}

class TestsValues: Codable {
    var type: TypeValue?
    var duration: DurationValue?
    var identifier: Identifier?
    var subtests: Tests?
    var name: NameValue?
    var testStatus: TestStatus?

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case duration
        case identifier
        case subtests
        case name
        case testStatus
    }
    
    var testCases: [TestCase]? {
        if subtests == nil {
            return [TestCase(name: name?.value,
                            duration: duration?.value,
                            identifier: identifier?.value,
                            status: testStatus?.value)]
        } else {
            return subtests?.testCases
        }
    }
}

class TestStatus: Codable {
    var type: TypeValue?
    var value: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case value = "_value"
    }
}

class Identifier: Codable {
    var type: TypeValue?
    var value: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case value = "_value"
    }
}

class DurationValue: Codable {
    var type: TypeValue?
    var value: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case value = "_value"
    }
}
