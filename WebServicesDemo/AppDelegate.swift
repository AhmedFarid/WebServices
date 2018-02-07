//
//  AppDelegate.swift
//  WebServicesDemo
//
//  Created by FARIDO on 1/4/18.
//  Copyright © 2018 FARIDO. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let api_token = helprt.getApiToken()
        {
            print("api_token: \(api_token)")
            
            
            let tab = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main")
            window?.rootViewController = tab
        }
        
        return true
    }
    
    
}

