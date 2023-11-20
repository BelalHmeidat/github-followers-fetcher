//
//  UsernameVerification.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/30/23.
//

import Foundation

class UsernameVerification{
    static private func isEnglishAndNumbers(_ input: String) -> Bool {
        let pattern = "^[A-Za-z0-9]+$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: input.utf16.count)
            if let _ = regex.firstMatch(in: input, options: [], range: range) {
                return true
            }
        }
        return false
    }
    static private func containsNonNumbers(_ input: String) -> Bool {
        let pattern = ".*[^0-9].*"
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let range = NSRange(location: 0, length: input.utf16.count)
            if let _ = regex.firstMatch(in: input, options: [], range: range) {
                return true
            }
        }
        return false
    }
    
    static func isUsernameValid(username : String)->Bool{
        return isEnglishAndNumbers(username) && containsNonNumbers(username)
    }

}
