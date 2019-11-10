import Foundation

protocol ValidationServiceType {
    func empty(_ string: String?) -> Bool
    func string(_ string: String?) -> Bool
    func username(_ string: String?) -> Bool
}

struct ValidationService: ValidationServiceType {
    
    func empty(_ string: String?) -> Bool {
        guard let string = string else { return true }
        return string.isEmpty
    }
    
    func string(_ string: String?) -> Bool {
        guard let string = string else { return false }
        return notEmptyString(string)
    }
    
    func username(_ string: String?) -> Bool {
        guard let string = string else { return false }
        return notEmptyString(string) && identityNumber(string)
    }
    
    func identityNumber(_ string: String?) -> Bool {
        guard let string = string else { return false }
        let DNIRegex = "^[0-9]{8,8}[A-Z]$"
        return string.matches(pattern: DNIRegex)
    }
}

// MARK: - Utils
private extension ValidationService {
    func notEmptyString(_ string: String?) -> Bool {
        guard let string = string else { return false }
        return !string.isEmpty && !string.isEmptyTrimmed
    }
}
