import UIKit

class helprt: NSObject {
    
    class func restartApp(){
        guard let window = UIApplication.shared.keyWindow else {return}
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        if getApiToken() == nil{
            vc = sb.instantiateInitialViewController()!
        }else{
            vc = sb.instantiateViewController(withIdentifier: "main")
        }
        
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        
    }
    
    class func saveApiToken(token: String){
        
        let def = UserDefaults.standard
        def.setValue(token, forKey: "api_token")
        def.synchronize()
        
        restartApp()
    }
    
    class func getApiToken()-> String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: "api_token")as? String
    }
    
}
