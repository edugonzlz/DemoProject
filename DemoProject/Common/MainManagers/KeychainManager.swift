import Foundation

protocol KeychainManagerType {
    func save(key: KeychainKey, string: String)
    func get(key: KeychainKey) -> String?
    func remove(key: KeychainKey)
    func removeAll()
}

enum KeychainKey: String {
    case authToken
    case userId
}

class KeychainManager: KeychainManagerType {
    func save(key: KeychainKey, string: String) {
        if let data = string.data(using: .utf8) {
            self.save(key: key.rawValue, data: data)
        }
    }
    
    func get(key: KeychainKey) -> String? {
        guard let data: Data = self.get(key: key.rawValue) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func remove(key: KeychainKey) {
        Keychain().removeKeychain(key: key.rawValue)
    }
    
    func removeAll() {
        Keychain().clearKeychain()
    }
}

private extension KeychainManager {
    func save(key: String, data: Data) {
        Keychain().saveKeychain(key: key, data: data)
    }
    
    func get(key: String) -> Data? {
        guard let data = Keychain().loadKeychain(key: key) else {
            return nil
        }
        return data
    }
}

private class Keychain {
    private func logStatus(action: String, key: String, status: OSStatus) {
        let success = (status == 0) ? "OK" : "Error"
        print("Keychain \(action) \(key): \(success)")
    }
    
    func saveKeychain(key: String, data: Data) {
        let query = [kSecClass as String: kSecClassGenericPassword as String,
                     kSecAttrAccount as String: key,
                     kSecValueData as String: data] as [String: Any]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        logStatus(action: "SAVE", key: key, status: status)
    }
    
    func loadKeychain(key: String) -> Data? {
        let query = [kSecClass as String: kSecClassGenericPassword as String,
                     kSecAttrAccount as String: key,
                     kSecReturnData as String: kCFBooleanTrue as Any,
                     kSecMatchLimit as String: kSecMatchLimitOne] as [String: Any]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        logStatus(action: "LOAD", key: key, status: status)
        
        if status == noErr {
            return dataTypeRef as! Data?
        }
        return nil
    }
    
    func removeKeychain(key: String) {
        let query = [kSecClass as String: kSecClassGenericPassword as String,
                     kSecAttrAccount as String: key] as [String: Any]
        let status = SecItemDelete(query as CFDictionary)
        logStatus(action: "REMOVE", key: key, status:status)
    }
    
    func clearKeychain() {
        let secItemClasses = [kSecClassGenericPassword]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            let status = SecItemDelete(spec)
            logStatus(action: "REMOVE", key: "ALL", status: status)
        }
    }
}
