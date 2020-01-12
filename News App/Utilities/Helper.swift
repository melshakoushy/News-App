//
//  Helper.swift
//  News App
//
//  Created by Mahmoud Elshakoushy on 1/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Helper: NSObject {
    
    class func saveCC(CC: String) {
        let def = UserDefaults.standard
        def.setValue(CC, forKey: "cc")
        def.synchronize()
        restartApp()
    }
    
    class func getCC() -> String! {
        let def = UserDefaults.standard
        return def.object(forKey: "cc") as? String
    }
    
    class func saveSource(Source: String) {
        let def = UserDefaults.standard
        def.setValue(Source, forKey: "source")
        def.synchronize()
        restartApp()
    }
    
    class func getSource() -> String! {
        let def = UserDefaults.standard
        return def.object(forKey: "source") as? String
    }
    
    class func saveFT(FT: Int) {
        let def = UserDefaults.standard
        def.setValue(FT, forKey: "ft")
        def.synchronize()
    }
    
    class func getFT() -> Int! {
        let def = UserDefaults.standard
        return def.object(forKey: "ft") as? Int
    }
    
    class func removeCC() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "cc")
        restartApp()
    }

    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        vc = sb.instantiateViewController(withIdentifier: "mainNav")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
}
