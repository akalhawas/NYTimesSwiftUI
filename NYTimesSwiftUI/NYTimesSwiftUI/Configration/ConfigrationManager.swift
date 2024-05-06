//
//  ConfigrationManager.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation

private enum BuildConfiguration {
    
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: String) throws -> T where T:
    
    LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        
        switch object {
            case let string as String:
                guard let value = T(string) else { fallthrough }
                return value
            default:
                throw Error.invalidValue
        }
    }
}

// MARK: Get BASE_URL from Configuration
enum API {
    static var baseURL: String {
        do {
            return try BuildConfiguration.value (for: "BASE_URL")
        } catch {
            fatalError (error.localizedDescription)
        }
    }
}

enum ConfigrationManager {
    enum Environment {
        case dev, qa, prod
    }
    
    static var environment: Environment {
        #if DEV
        return .dev
        #elseif QA
        return .qa
        #elseif PROD
        return .prod
        #endif
    }
}
