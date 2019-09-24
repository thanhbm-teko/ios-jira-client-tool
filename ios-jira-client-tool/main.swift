//
//  main.swift
//  ios-jira-client-tool
//
//  Created by Tung Nguyen on 9/23/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation
import Darwin

let resultPath = "./TestSummaries.xcresult"

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
    task.waitUntilExit()
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

let testCasesArg = CommandLine.arguments.first { $0.hasPrefix("-test-cases=")}

guard let firstEqualIndex = testCasesArg?.firstIndex(of: "=") else {
    print("Cannot find test cases!")
    exit(0)
}

guard let testCasesString = testCasesArg?[firstEqualIndex...].dropFirst() else {
    print("Cannot find test cases!")
    exit(0)
}

let testCases = testCasesString.split(separator: ",").map { String($0) }

let issueLinkArg = CommandLine.arguments.first { $0.hasPrefix("-issue-key=")}

guard let issueLinkIndex = issueLinkArg?.firstIndex(of: "=") else {
    print("Cannot find issue key!")
    exit(0)
}

guard let issueLink = issueLinkArg?[issueLinkIndex...].dropFirst() else {
    print("Cannot find issue key!")
    exit(0)
}

let issueKey = String(issueLink)

// - MARK: Begin load configurations
let configPath = Bundle.main.path(forResource: "config", ofType: "plist")

guard let path = configPath, FileManager.default.fileExists(atPath: path) else {
    print("Cannot find config.plist!")
    exit(0)
}

let configurations = FileUtils.loadConfig(path: path)

let username = configurations?["jiraUsername"] as! String
let token = configurations?["jiraPassword"] as! String
let projectKey = configurations?["projectKey"] as! String
let scheme = configurations?["scheme"] as! String
let workspace = configurations?["workspace"] as! String
let device = configurations?["device"] as! String
let folder = configurations?["folder"] as! String
let cycleFolder = configurations?["cycleFolder"] as! String
let cycleName = configurations?["cycleName"] as! String

guard let auth = "\(username):\(token)".data(using: .utf8)?.base64EncodedString() else {
    print("Cannot get credentials!")
    exit(0)
}

var commandString = "xcodebuild test -workspace \(workspace) -scheme \(scheme) -destination \"name=\(device)\" -resultBundlePath \(resultPath) -derivedDataPath ./build"

testCases.forEach { string in
    commandString = commandString + " -only-testing:\(string) "
}

//run("rm -rf \(resultPath)")

if FileManager.default.fileExists(atPath: resultPath) {
    try? FileManager.default.removeItem(atPath: resultPath)
}

_ = shell(commandString)

let out = shell("xcrun xcresulttool get --format json --path \(resultPath)")

guard let data = out.data(using: .utf8), let result = try? JSONDecoder().decode(Result.self, from: data) else {
    print("Cannot process result")
    exit(0)
}

guard let summaryId = result.actions?.values?.first?.actionResult?.testsRef?.id?.value else {
    print("Cannot get test summaries")
    exit(0)
}

let summary = shell("xcrun xcresulttool get --format json --path ./TestSummaries.xcresult --id \(summaryId)")

guard let summaryData = summary.data(using: .utf8), let summaries = try? JSONDecoder().decode(TestSummaries.self, from: summaryData) else {
    print("Cannot process summaries")
    exit(0)
}

let api = Api()

let semaphore = DispatchSemaphore(value: 0)

let cases: [TestCase] = summaries.summaries?.values?.first?.testableSummaries?.values?.first?.tests?.testCases ?? [TestCase]()

let dispatchGroup = DispatchGroup()

cases.forEach { c in
    
    dispatchGroup.enter()
    
    try? api.findTestCase(authorization: auth, projectKey: projectKey, name: c.identifier ?? "", completion: { (cases, error) in
        if let matches = cases?.first {
            print("Test case \(c.identifier ?? "") existed on jira")
            c.key = matches.key
            dispatchGroup.leave()
        }
        else {
            try? api.createTestCase(authorization: auth, projectKey: projectKey, folder: folder, issueKey: issueKey, testCase: c) { (response, error) in
                c.key = response?.key
                print("Test case \(c.key ?? "") is created successfully")

                dispatchGroup.leave()
            }
        }
        
    })
    
}

dispatchGroup.notify(queue: DispatchQueue.main) {
    let testCases = cases.filter { $0.key != nil }
    print("[✓] Total \(testCases.count) test cases")
    try? api.createTestCycle(authorization: auth,
                             projectKey: projectKey,
                             cycleName: cycleName,
                             folder: cycleFolder,
                             issueKey: issueKey,
                             testCases: testCases, completion: { (response, error) in
        if let error = error {
            print(error)
        } else if let cycleKey = response?.key {
            print("[✓] Cycle with key = \(cycleKey) is created successfully")
        }
        exit(0)
    })
}

dispatchMain()
