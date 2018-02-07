import Foundation

extension Bool {
    var toInt: Int {
        
        return NSNumber(booleanLiteral: self).intValue
    }
}
