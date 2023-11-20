import Foundation


func isEnglishAndNumbers(_ input: String) -> Bool {
    let pattern = "^[A-Za-z0-9]+$"
    if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
        let range = NSRange(location: 0, length: input.utf16.count)
        if let _ = regex.firstMatch(in: input, options: [], range: range) {
            return true
        }
    }
    return false
}
func containsOnlyLetters(_ input: String) -> Bool {
    let pattern = "^[a-zA-Z]+$"
    if let regex = try? NSRegularExpression(pattern: pattern) {
        let range = NSRange(location: 0, length: input.utf16.count)
        if let _ = regex.firstMatch(in: input, options: [], range: range) {
            return true
        }
    }
    return false
}
func containsOnlyLettersAtoZ(_ input: String) -> Bool {
    let pattern = "^[a-zA-Z]+$"
    if let regex = try? NSRegularExpression(pattern: pattern) {
        let range = NSRange(location: 0, length: input.utf16.count)
        if let _ = regex.firstMatch(in: input, options: [], range: range) {
            return true
        }
    }
    return false
}
func containsNonNumbers(_ input: String) -> Bool {
    let pattern = ".*[^0-9].*"
    if let regex = try? NSRegularExpression(pattern: pattern) {
        let range = NSRange(location: 0, length: input.utf16.count)
        if let _ = regex.firstMatch(in: input, options: [], range: range) {
            return true
        }
    }
    return false
}

var username = "Hello@123"
var empty = ""
var username2 = "hello"
var username3 = "2922"
var username4 = "helO34"


isEnglishAndNumbers(empty) ?
    (!containsNonNumbers(empty) ? print("invlaid") : print("valid")) : print("invlaid")


isEnglishAndNumbers("helO34") && containsNonNumbers("helO34")
