//
//  SessionManager.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 16/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation
import SwiftyPlistManager

public struct Fields {
    
    static let pollEndpoint: String = "pollEndpoint"
    
}

class SessionManager: NSObject {
    
    static let shared: SessionManager = { return SessionManager() }()
    public var verbose: Bool = false
    
    public func addValue(_ value: Any, forKey: String) {
        SwiftyPlistManager.shared.save(value, forKey: forKey, toPlistWithName: Keys.pListName) { (error) in
            if error == nil {
                if verbose {
                    print("Value \(forKey) successfully saved into plist.")
                }
            } else {
                if verbose {
                    print("Error - Value \(forKey) was not saved into plist.")
                }
            }
        }
    }
    
    public func getValueForKey(_ key: String) -> Any? {
        guard let fetchedValue = SwiftyPlistManager.shared.fetchValue(for: key, fromPlistWithName: Keys.pListName) else {
            return nil
        }
        
        return fetchedValue
    }
    
    public func clearSession() {
        addValue("", forKey: Fields.pollEndpoint)
    }
    
    public func isSessionCreated() -> Bool {
        guard let session = getValueForKey(Fields.pollEndpoint) as? String, !session.isEmpty else {
            return false
        }
        
        return true
    }
    
    public func getPollEndpoint() -> String? {
        guard let session = getValueForKey(Fields.pollEndpoint) as? String, !session.isEmpty else {
            return nil
        }
        
        return session
    }
    
}

extension SessionManager {
    
    private struct Keys {
        
        static let pListName: String = "Session"
        
    }
    
}
