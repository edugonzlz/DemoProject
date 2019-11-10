import Foundation
import UIKit

// MARK: - Utils
extension String {
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

// MARK: - Checkers
extension String {
    func matches(pattern: String) -> Bool {
        return range(of: pattern,
                     options: String.CompareOptions.regularExpression,
                     range: nil, locale: nil) != nil
    }
    
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    public var hasUppercaseLetters: Bool {
        return rangeOfCharacter(from: .uppercaseLetters, options: .literal, range: nil) != nil
    }
    
    public var isEmptyTrimmed: Bool {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 
    }
}



