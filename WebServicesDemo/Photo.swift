import UIKit
import Foundation
import SwiftyJSON


class Photo: NSObject {
    var id: Int
    var url: String
    
    
    init?(dict: [String: JSON]) {
        guard let id = dict["id"]?.toInt, let photo = dict["photo"]?.toImagePath, !photo.isEmpty else { return nil }
        
        self.id = id
        self.url = photo
    }
}
