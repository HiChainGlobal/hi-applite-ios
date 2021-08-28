//
//  WelcomeVC.swift
//  HiWebApp
//
//  Created by Kiran on 8/11/21.
//

import UIKit
import SDWebImage

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var animatedImageView: SDAnimatedImageView!
    var isNeedToReload: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let animatedImage = SDAnimatedImage(named: "splash_anim.gif")
        self.animatedImageView.image = animatedImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkInternetAndMoveToNextPage()
    }
    
    func checkInternetAndMoveToNextPage() {
        guard AppDelegate.shared().isConnectedToNetwork() else {
            let alert = UIAlertController(title: "No Internet Connection!", message: "It seems you are not connected to the internet, Kindly connect and try again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Retry", style: .cancel) { (action) in
                self.checkInternetAndMoveToNextPage()
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            print("Move to webview")
        }
    }

}
