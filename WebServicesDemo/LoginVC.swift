import UIKit
import Alamofire
import SwiftyJSON

class LoginVC: UIViewController {
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Login(_ sender: UIButton) {
        guard let email = EmailTF.text, !email.isEmpty else { return }
        guard let password = PasswordTF.text, !password.isEmpty else { return }
        
        API.login(email: email, password: password) { (error:Error?, success :Bool) in
            if success {
                ///
            }else{
                ////
            }
            
        }
        
    }

}

