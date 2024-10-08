//
//  ExampleLog.swift
//  MMLog
//
//  Created by Mihaela MJ on 23.09.2024..
//

import Foundation

public struct Message: Hashable, Codable {
    public var text: String
    public let uuid: UUID
}

extension Message: DictionaryRepresentable {
    public func toDictionary() -> [String: Any] {
        let dict: [String: Any] = [
            "text": text,
            "uuid": uuid.uuidString
        ]
        return dict
    }
}

public class ExampleLog: BaseLog {
    
    // MARK: Overrides -
    
    open override var logFileName: String { "_example_log.json" }
    open override var logPrefix: String { "Example->" }
    
    // MARK: Singleton -
    
    public static let shared = ExampleLog()
}

// MARK: Logging -

public extension ExampleLog {
    
    func logSomeMessages(receivedMessages: [DictionaryRepresentable]? = nil,
                         currentMessages: [DictionaryRepresentable]? = nil,
                         updatedMessages: [DictionaryRepresentable]? = nil) {
        guard Self.active else { return }
        
        var logEntry: LogEntry = ["event" : "SomeMessages"]
        
        if let receivedMessages = receivedMessages {
            logEntry["receivedMessages"] = receivedMessages.map { $0.toDictionary() }
        }
        if let currentMessages = currentMessages {
            logEntry["currentMessages"] = currentMessages.map { $0.toDictionary() }
        }
        if let updatedMessages = updatedMessages {
            logEntry["updatedMessages"] = updatedMessages.map { $0.toDictionary() }
        }
        append(logEntry)
    }
    
    func logOneMessage(_ message: DictionaryRepresentable) {
        guard Self.active else { return }
        
        let logEntry: LogEntry = [
            "event": "OneMessage",
            "message": message.toDictionary()
        ]
        append(logEntry)
    }
    
    func logCallback(key: String, payload: [String: Any], response: [Any]) {
        guard Self.active else { return }
        
        let logEntry: LogEntry = [
            "event": "callback",
            "key": key,
            "payload": payload,
            "response": response
        ]
        
        if Self.consoleActive {
            print("\(logPrefix): callback, `\(key)`, payload: \(payload)")
            printPrettyJSON(from: response, name: "response")
        }
        
        append(logEntry)
    }
    
    func log(action: String,
             subActionName: String,
             message: DictionaryRepresentable? = nil,
             messages: [DictionaryRepresentable]? = nil) {
        guard Self.active else { return }
        
        var logEntry: LogEntry = ["action": action]
        logEntry["subAction"] = subActionName
        
        // Add message to log if present
        if let message = message {
            logEntry["message"] = message.toDictionary()
        }
        
        // Add messages array to log if present
        if let messages = messages {
            logEntry["messages"] = messages.map { $0.toDictionary() }
        }
        
        // Append the log entry
        append(logEntry)
    }
    
}
