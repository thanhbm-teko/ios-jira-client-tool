//
//  Result.swift
//  ios-jira-client-tool
//
//  Created by Tung Nguyen on 9/23/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

import Foundation

// MARK: - Result
struct Result: Codable {
    let type: TypeClass
    let actions: Actions
    let issues: Issues
    let metadataRef: PurpleRef
    let metrics: ActionResultMetrics

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case actions, issues, metadataRef, metrics
    }
}

// MARK: - Actions
struct Actions: Codable {
    let type: TypeClass
    let values: [ActionsValue]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
}

// MARK: - TypeClass
struct TypeClass: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "_name"
    }
}

// MARK: - ActionsValue
struct ActionsValue: Codable {
    let type: TypeClass
    let actionResult: ActionResult
    let buildResult: BuildResult
    let endedTime: PuneHedgehog
    let runDestination: RunDestination
    let schemeCommandName, schemeTaskName, startedTime, title: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case actionResult, buildResult, endedTime, runDestination, schemeCommandName, schemeTaskName, startedTime, title
    }
}

// MARK: - ActionResult
struct ActionResult: Codable {
    let type: TypeClass
    let coverage: ActionResultCoverage
    let diagnosticsRef: DiagnosticsRefClass
    let issues: Issues
    let logRef: PurpleRef
    let metrics: ActionResultMetrics
    let resultName, status: PuneHedgehog
    let testsRef: PurpleRef

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case coverage, diagnosticsRef, issues, logRef, metrics, resultName, status, testsRef
    }
}

// MARK: - ActionResultCoverage
struct ActionResultCoverage: Codable {
    let type: TypeClass
    let archiveRef: DiagnosticsRefClass
    let hasCoverageData: PuneHedgehog
    let reportRef: DiagnosticsRefClass

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case archiveRef, hasCoverageData, reportRef
    }
}

// MARK: - DiagnosticsRefClass
struct DiagnosticsRefClass: Codable {
    let type: TypeClass
    let id: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case id
    }
}

// MARK: - PuneHedgehog
struct PuneHedgehog: Codable {
    let type: TypeClass
    let value: String

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case value = "_value"
    }
}

// MARK: - Issues
struct Issues: Codable {
    let type: TypeClass
    let warningSummaries: WarningSummaries

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case warningSummaries
    }
}

// MARK: - WarningSummaries
struct WarningSummaries: Codable {
    let type: TypeClass
    let values: [WarningSummariesValue]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
}

// MARK: - WarningSummariesValue
struct WarningSummariesValue: Codable {
    let type: TypeClass
    let issueType, message: PuneHedgehog
    let documentLocationInCreatingWorkspace: DocumentLocationInCreatingWorkspace?

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case issueType, message, documentLocationInCreatingWorkspace
    }
}

// MARK: - DocumentLocationInCreatingWorkspace
struct DocumentLocationInCreatingWorkspace: Codable {
    let type: TypeClass
    let concreteTypeName, url: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case concreteTypeName, url
    }
}

// MARK: - PurpleRef
struct PurpleRef: Codable {
    let type: TypeClass
    let id: PuneHedgehog
    let targetType: TargetType

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case id, targetType
    }
}

// MARK: - TargetType
struct TargetType: Codable {
    let type: TypeClass
    let name: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case name
    }
}

// MARK: - ActionResultMetrics
struct ActionResultMetrics: Codable {
    let type: TypeClass
    let testsCount, warningCount: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case testsCount, warningCount
    }
}

// MARK: - BuildResult
struct BuildResult: Codable {
    let type: TypeClass
    let coverage: BuildResultCoverage
    let issues: Issues
    let logRef: PurpleRef
    let metrics: BuildResultMetrics
    let resultName, status: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case coverage, issues, logRef, metrics, resultName, status
    }
}

// MARK: - BuildResultCoverage
struct BuildResultCoverage: Codable {
    let type: TypeClass

    enum CodingKeys: String, CodingKey {
        case type = "_type"
    }
}

// MARK: - BuildResultMetrics
struct BuildResultMetrics: Codable {
    let type: TypeClass
    let warningCount: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case warningCount
    }
}

// MARK: - RunDestination
struct RunDestination: Codable {
    let type: TypeClass
    let displayName: PuneHedgehog
    let localComputerRecord: LocalComputerRecord
    let targetArchitecture: PuneHedgehog
    let targetDeviceRecord: TargetDeviceRecord
    let targetSDKRecord: TargetSDKRecord

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case displayName, localComputerRecord, targetArchitecture, targetDeviceRecord, targetSDKRecord
    }
}

// MARK: - LocalComputerRecord
struct LocalComputerRecord: Codable {
    let type: TypeClass
    let busSpeedInMHz, cpuCount, cpuKind, cpuSpeedInMHz: PuneHedgehog
    let identifier, isConcreteDevice, logicalCPUCoresPerPackage, modelCode: PuneHedgehog
    let modelName, modelUTI, name, nativeArchitecture: PuneHedgehog
    let operatingSystemVersion, operatingSystemVersionWithBuildNumber, physicalCPUCoresPerPackage: PuneHedgehog
    let platformRecord: PlatformRecord
    let ramSizeInMegabytes: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case busSpeedInMHz, cpuCount, cpuKind, cpuSpeedInMHz, identifier, isConcreteDevice, logicalCPUCoresPerPackage, modelCode, modelName, modelUTI, name, nativeArchitecture, operatingSystemVersion, operatingSystemVersionWithBuildNumber, physicalCPUCoresPerPackage, platformRecord, ramSizeInMegabytes
    }
}

// MARK: - PlatformRecord
struct PlatformRecord: Codable {
    let type: TypeClass
    let identifier, userDescription: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case identifier, userDescription
    }
}

// MARK: - TargetDeviceRecord
struct TargetDeviceRecord: Codable {
    let type: TypeClass
    let identifier, isConcreteDevice, modelCode, modelName: PuneHedgehog
    let modelUTI, name, nativeArchitecture, operatingSystemVersion: PuneHedgehog
    let operatingSystemVersionWithBuildNumber: PuneHedgehog
    let platformRecord: PlatformRecord

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case identifier, isConcreteDevice, modelCode, modelName, modelUTI, name, nativeArchitecture, operatingSystemVersion, operatingSystemVersionWithBuildNumber, platformRecord
    }
}

// MARK: - TargetSDKRecord
struct TargetSDKRecord: Codable {
    let type: TypeClass
    let identifier, name, operatingSystemVersion: PuneHedgehog

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case identifier, name, operatingSystemVersion
    }
}

