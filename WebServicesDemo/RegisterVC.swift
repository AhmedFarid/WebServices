import UIKit
import Alamofire
import SwiftyJSON

class RegisterVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var cpasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Register(_ sender: UIButton) {

        guard let name = nameTF.text?.trimmed, !name.isEmpty else { return }
        guard let email = emailTF.text?.trimmed, !email.isEmpty else { return }
        guard let password = passwordTF.text, !password.isEmpty else { return }
        guard let cpassword = cpasswordTF.text, !cpassword.isEmpty else { return }
        
        guard password == cpassword else { return }
        
        
        API.register(name: name, email: email, password: password) { (error: Error?, success:Bool) in
            if success{
                ///
                print("Reigster succeed")
            }
            else{
                ///
            }
        }
        
    }
}
