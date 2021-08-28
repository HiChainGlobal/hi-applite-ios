//
//  Utility.swift
//  HiWebApp
//
//  Created by Kiran on 8/11/21.
//

import UIKit
import Reachability

class Utility: NSObject {
    
    class func isConnectedToNetwork() -> Bool {
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
