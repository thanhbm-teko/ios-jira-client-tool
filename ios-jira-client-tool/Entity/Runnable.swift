//
//  Runnable.swift
//  ios-jira-client-tool
//
//  Created by Tung N. on 9/23/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

class Runnable {

    func loadSample() {
        guard let url = Bundle.main.url(forResource: "summaries", withExtension: "json") else {
            print("Cannot find summaries.json file.")
            return
        }
        guard let data = try? Data(contentsOf: url) else { return }
             
        let testSummaries = try! JSONDecoder().decode(TestSummaries.self, from: data)
        print(testSummaries.summaries?.values?.first?.testableSummaries?.values?.first?.tests?.testCases.first?.identifier)
    }
    
}
