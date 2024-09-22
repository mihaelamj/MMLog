//
//  ExampleLog
//
//  Created by Mihaela MJ on 23.09.2024..
//

import Foundation

public class ExampleLog: BaseLog {
    
    // MARK: Overrides -
    
    open override var logFileName: String { "_reschat_UI_log.json" }
    open override var logPrefix: String { "DBGG: UI_Event->" }
    
    // MARK: Singleton -
    
    public static let shared = ExampleLog()
}

// MARK: Logging -

public extension ExampleLog {
    
    // Example of logging history messages
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
    
    func logSocketCallback(key: String, payload: [String: Any], response: [Any]) {
        guard Self.active else { return }
        
        let logEntry: LogEntry = [
            "event": "callback",
            "key": key,
            "payload": payload,
            "response": response
        ]
        
        if Self.consoleActive {
            print("\(logPrefix): callback, `\(key)`, payload: \(payload), response: \(response)")
        }
        
        append(logEntry)
    }

}
