import UIKit
import Alamofire

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var iv: UIImageView!
    
    var photo: Photo? {
        didSet {
            guard let photo = photo else { return }
            
            iv.image = #imageLiteral(resourceName: "placeholder")
            
            
            Alamofire.request(photo.url).response { response in
                if let data = response.data , let image = UIImage(data: data) {
                    self.iv.image = image
                }
            }
        }
    }
    
    
  }
