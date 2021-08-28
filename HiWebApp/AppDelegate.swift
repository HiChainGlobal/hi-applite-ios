//
//  AppDelegate.swift
//  HiWebApp
//
//  Created by Kiran on 8/11/21.
//

import UIKit
import Reachability

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    fileprivate static let instance = UIApplication.shared.delegate as! AppDelegate
    class func shared() -> AppDelegate {
        return instance
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func isConnectedToNetwork() -> Bool {
        do {
            let reachability = try? Reachability()
            switch reachability!.connection {
            case .wifi:
                return true
            case .cellular:
                return true
            case .none:
                return false
            case .unavailable:
                return false
            }
        }
    }
}

