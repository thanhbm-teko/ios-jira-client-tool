//
//  main.swift
//  ios-jira-client-tool
//
//  Created by Tung Nguyen on 9/23/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation
import Darwin

enum Command: String {
    case test
}

enum Args: String {
    case testCases = "test-cases"
}

@discardableResult
func run(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

func shell(_ command: String) -> String {
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = ["-c", command]

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String

    return output
}

guard CommandLine.arguments.count > 1 else {
    print("Please enter a command. Ex: 'test...'")
    exit(0)
}

let action = CommandLine.arguments.dropFirst().first!

guard let command = Command(rawValue: action) else {
    print("'\(action)' command is not supported!")
    exit(0)
}

let testCasesArg = CommandLine.arguments.first { $0.hasPrefix("test-cases=")}

guard let firstEqualIndex = testCasesArg?.firstIndex(of: "=") else {
    print("Cannot find test cases!")
    exit(0)
}

guard let testCasesString = testCasesArg?[firstEqualIndex...].dropFirst() else {
    print("Cannot find test cases!")
    exit(0)
}

let workspace = "VNShop.xcworkspace"
let scheme = "VNShop"
let destination = "name=iPhone 8"
let testCases1 = "VNShopTests/ProductAttributesViewControllerTests"
let testCases2 = "VNShopTests/SearchProductViewControllerTests/testNumberOfSections"

let configPath = Bundle.main.path(forResource: "config", ofType: "plist")

guard let path = configPath, FileManager.default.fileExists(atPath: path) else {
    print("Cannot find config.plist!")
    exit(0)
}

let configurations = FileUtils.loadConfig(path: path)
print(configurations)
//
//run("xcodebuild", "test", "-workspace", workspace, "-scheme", scheme, "-destination", destination, "-derivedDataPath", "./build", "-only-testing:\(testCases1)", "-only-testing:\(testCases2)", "-resultBundlePath", "./TestSummaries.xcresult")
//
//let out = shell("xcrun xcresulttool get --format json --path ./TestSummaries.xcresult")
//
//guard let data = out.data(using: .utf8), let result = try? JSONDecoder().decode(Result.self, from: data) else {
//    print("Cannot process result")
//    exit(0)
//}
//
//guard let summaryId = result.actions?.values?.first?.actionResult?.testsRef?.id?.value else {
//    print("Cannot get test summaries")
//    exit(0)
//}
//
//let summary = shell("xcrun xcresulttool get --format json --path ./TestSummaries.xcresult --id \(summaryId)")
//
//guard let summaryData = summary.data(using: .utf8), let summaries = try? JSONDecoder().decode(TestSummaries.self, from: summaryData) else {
//    print("Cannot process summaries")
//    exit(0)
//}
//
//let cases: [TestCase] = summaries.summaries?.values?.first?.testableSummaries?.values?.first?.tests?.testCases ?? [TestCase]()
//cases.forEach { c in
//    print(c.identifier ?? "")
//}
//print("[Complete] \(cases.count) test cases.")
