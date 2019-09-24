import Foundation

class Result: Codable {
    
    let type: TypeValue?
    let actions: Actions?
    
    var testId: String? {
        return self.actions?.values?.first?.actionResult?.testsRef?.id?.value

    }
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case actions
    }
    
}

class Actions: Codable {
    let type: TypeValue?
    let values: [Value]?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
}

class TypeValue: Codable {
    let name: String?
    let supertype: TypeValue?
    
    enum CodingKeys: String, CodingKey {
        case name = "_name"
        case supertype = "_supertype"
    }
}

class Value: Codable {
    let type: TypeValue?
    let actionResult: ActionResult?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case actionResult
    }
    
}

class ActionResult: Codable {
    let type: TypeValue?
    let testsRef: TestsRef?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case testsRef
    }
}

class TestsRef: Codable {
    let type: TypeValue?
    let id: ID?
    let targetType: TargetType?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case id
        case targetType
    }
}

class TargetType: Codable {
    let type: TypeValue?
    let name: NameValue?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case name = "_value"
    }

}

class NameValue: Codable {
    let type: TypeValue?
    let value: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case value = "_value"
    }
}

class ID: Codable {
    let type: TypeValue?
    let value: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case value = "_value"
    }
}
