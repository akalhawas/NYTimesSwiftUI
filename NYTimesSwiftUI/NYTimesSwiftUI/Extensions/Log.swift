//
//  Log.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation

enum Log {
    fileprivate enum LogLevel {
        case info
        case warning
        case error
        
        fileprivate var prefix: String {
            switch self {
                case .info:    return "ℹ️ INFO"
                case .warning: return "⚠️ WARN"
                case .error:   return "❌ ERROR"
            }
        }
    }
    
    fileprivate struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            return "\((file as NSString).lastPathComponent): \(line) \(function)"
        }
    }
   
    static func info(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .info, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
    
    static func warning(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .warning, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
    
    static func error(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .error, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }

    fileprivate static func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
        let logComponents = ["[\(level.prefix)]", str]
        
        var fullString = logComponents.joined(separator: " ")
        if shouldLogContext {
            fullString += " ➜ \(context.description)"
        }
        
        #if DEV
        print(fullString)
        #endif
    }
    
    static func statusCode(_ statusCode: Int) {
        #if DEV
        print("[\(statusCode)]")
        #endif
    }
    
    static func environment(){
        #if DEV
        print("DEBUG: Environment = \(ConfigrationManager.environment)")
        #endif
    }
}

