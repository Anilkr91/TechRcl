//
//  ViewController.swift
//  RECL
//
//  Created by Macintosh on 21/08/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var webView = UIWebView()
    let url = URL(string: "http://125.22.91.10:8080/")
    
    let loader = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        openLoadRequest(url: url!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openLoadRequest(url: URL) {
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
    }
    
    func setupWebView() {
        webView = UIWebView(frame: UIScreen.main.bounds)
        view.addSubview(webView)
        webView.delegate = self
    }
    
    func showLoading() {
        loader.center = self.view.center
        loader.activityIndicatorViewStyle = .gray
        view.addSubview(loader)
        loader.startAnimating()
        
    }
    
    func stopLoading() {
        self.loader.stopAnimating()
        
    }
}

extension ViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if let url = request.url, navigationType == .linkClicked {
                
                if let scheme = url.scheme {
                    openAppWithUrlScheme(scheme: scheme, url: url)
                }
                openLoadRequest(url: url)
                return false
        }
        return true
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        showLoading()
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        stopLoading()
    }
    
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error.localizedDescription)
        
    }
    
    
    func openAppWithUrlScheme(scheme: String, url: URL) {
        if scheme == "tel" {
            validateToOpenUrl(url: url)
            
        } else if scheme == "mailto" {
            validateToOpenUrl(url: url)
        } else {
            
        }
    }
    
    
    func validateToOpenUrl(url: URL) {
        UIApplication.shared.openURL(url)
    }
}
