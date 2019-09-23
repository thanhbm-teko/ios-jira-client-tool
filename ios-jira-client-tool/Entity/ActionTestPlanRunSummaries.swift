// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let actionTestPlanRunSummaries = try? newJSONDecoder().decode(ActionTestPlanRunSummaries.self, from: jsonData)

import Foundation

// MARK: - ActionTestPlanRunSummaries
struct ActionTestPlanRunSummaries: Codable {
    let type: PurpleType
    let summaries: Summaries

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case summaries
    }
}

// MARK: - Summaries
struct Summaries: Codable {
    let type: PurpleType
    let values: [SummariesValue]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
}

// MARK: - PurpleType
struct PurpleType: Codable {
    let name: NameEnum

    enum CodingKeys: String, CodingKey {
        case name = "_name"
    }
}

enum NameEnum: String, Codable {
    case actionAbstractTestSummary = "ActionAbstractTestSummary"
    case actionTestPlanRunSummaries = "ActionTestPlanRunSummaries"
    case array = "Array"
    case double = "Double"
    case string = "String"
}

// MARK: - SummariesValue
struct SummariesValue: Codable {
    let type: ValueSupertype
    let name: Name
    let testableSummaries: TestableSummaries

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case name, testableSummaries
    }
}

// MARK: - Name
struct Name: Codable {
    let type: PurpleType
    let value: String

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case value = "_value"
    }
}

// MARK: - TestableSummaries
struct TestableSummaries: Codable {
    let type: PurpleType
    let values: [TestableSummariesValue]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
}

// MARK: - TestableSummariesValue
struct TestableSummariesValue: Codable {
    let type: ValueSupertype
    let diagnosticsDirectoryName, name, projectRelativePath, targetName: Name
    let testKind: Name
    let tests: Tests

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case diagnosticsDirectoryName, name, projectRelativePath, targetName, testKind, tests
    }
}

// MARK: - PurpleValue
struct PurpleValue: Codable {
    let type: FluffyType
    let duration, identifier, name: Name
    let subtests: Tests?
    let testStatus: Name?

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case duration, identifier, name, subtests, testStatus
    }
}

// MARK: - Subtests
struct Subtests: Codable {
    let type: PurpleType
    let values: [PurpleValue]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
}

// MARK: - TestsValue
struct TestsValue: Codable {
    let type: FluffyType
    let duration, identifier, name: Name
    let subtests: Subtests

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case duration, identifier, name, subtests
    }
}

// MARK: - Tests
struct Tests: Codable {
    let type: PurpleType
    let values: [TestsValue]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
}

// MARK: - FluffyType
struct FluffyType: Codable {
    let name: String
    let supertype: ValueSupertype

    enum CodingKeys: String, CodingKey {
        case name = "_name"
        case supertype = "_supertype"
    }
}

// MARK: - ValueSupertype
struct ValueSupertype: Codable {
    let name: String
    let supertype: PurpleType

    enum CodingKeys: String, CodingKey {
        case name = "_name"
        case supertype = "_supertype"
    }
}
