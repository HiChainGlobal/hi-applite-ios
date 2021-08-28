//
//  WebViewController.swift
//  HiWebApp
//
//  Created by Kiran on 8/11/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var toolBar: UIToolbar?
    @IBOutlet weak var forwardBarButtonItem: UIBarButtonItem?
    @IBOutlet weak var backBarButtonItem: UIBarButtonItem?
    @IBOutlet weak var reloadBarButtonItem: UIBarButtonItem?
    
    var wkWebView: WKWebView!
    var bottomInset : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.webView.isHidden = true
        
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = [.all]
        self.wkWebView = WKWebView(frame: .zero, configuration: config)
        self.view.addSubview(self.wkWebView)
        self.wkWebView.translatesAutoresizingMaskIntoConstraints = false
        self.wkWebView.navigationDelegate = self
        
        self.webView.navigationDelegate = self
        guard Utility.isConnectedToNetwork() else {
            return
        }
        
        if let url = URL(string: "https://web.hi.com/#") {
//            self.webView.load(URLRequest(url: url))
            self.wkWebView.load(URLRequest(url: url))
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let safe = view.safeAreaLayoutGuide
//        print((UIApplication.shared.windows[0]).safeAreaInsets)
//        NSLayoutConstraint.activate([
//            self.wkWebView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 0)
//        ])
//
        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.wkWebView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            self.wkWebView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            self.wkWebView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 0),
            self.wkWebView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -50)
        ])
    }
    
    func updateToolbarButtons() {
//        self.backBarButtonItem?.isEnabled = self.webView.canGoBack
//        self.forwardBarButtonItem?.isEnabled = self.webView.canGoForward
        
        self.backBarButtonItem?.isEnabled = self.wkWebView.canGoBack
        self.forwardBarButtonItem?.isEnabled = self.wkWebView.canGoForward
    }
    
    @IBAction func didClickOnBack(_ sender: Any) {
//        self.webView.goBack()
        self.wkWebView.goBack()
        self.updateToolbarButtons()
    }
    
    @IBAction func didClickOnForward(_ sender: Any) {
//        self.webView.goForward()
        self.wkWebView.goForward()
        self.updateToolbarButtons()
    }
    
    @IBAction func didClickOnReload(_ sender: Any) {
//        self.webView.reload()
        self.wkWebView.reload()
        self.updateToolbarButtons()
    }
    
}

//MARK:- WKNavigationDelegate Methods
extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
        print("Start Loading")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        print("Finish Loading")
        self.updateToolbarButtons()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
        self.updateToolbarButtons()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function)
        self.updateToolbarButtons()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        self.updateToolbarButtons()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(#function)
        self.updateToolbarButtons()
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        
        if let scheme = url.scheme, !( scheme == "http" || scheme == "https") {
            guard UIApplication.shared.canOpenURL(url) else {
                decisionHandler(.allow)
                return
            }
            UIApplication.shared.open(url, options: [:]) { status in
                
            }
            decisionHandler(.cancel)
        } else if url.absoluteString.contains("app.link") {
            decisionHandler(.allow)
        } else if url.absoluteString.contains("https://hi.com/legal-privacy") {
            guard UIApplication.shared.canOpenURL(url) else {
                decisionHandler(.allow)
                return
            }
            UIApplication.shared.open(url, options: [:]) { status in
                
            }
            decisionHandler(.cancel)
        }
        else {
            decisionHandler(.allow)
            if let currentURL = self.webView.url, url == currentURL {
                return
            }
            return
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print(#function)
        self.updateToolbarButtons()
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        self.updateToolbarButtons()
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print(#function)
        self.updateToolbarButtons()
    }
}
