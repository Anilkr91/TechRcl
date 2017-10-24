//
//  ViewController.swift
//  RECL
//
//  Created by Macintosh on 21/08/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    let url = URL(string: "http://125.22.91.10:8080/")
    
    let loader = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        openLoadRequest(url: url!)
    }
    
    func openLoadRequest(url: URL) {
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
    }
}

extension ViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if let url = request.url, navigationType == .linkClicked {
            
            print(url)
            
            if let scheme = url.scheme   {
                openAppWithUrlScheme(scheme: scheme, url: url)
            }
            
            if url.absoluteString.contains("#") {
                if url.absoluteString.contains("dashboard") {
                    return true
               
                } else {
                    onBackPressed()
                }
                
            } else if url.absoluteString.contains("maps/place/") {
                showBackButton()
                print("map")
                
            } else if url.absoluteString.contains("facebook.com/") {
                showBackButton()
                print("facebook")
                
            } else if url.absoluteString.contains("youtube.com/") {
                showBackButton()
                print("youtube")
                
            } else if url.absoluteString.contains("twitter.com/") {
                showBackButton()
                print("twitter")
                
            } else if url.absoluteString.contains("linkedin.com/") {
                showBackButton()
                print("linkedin")
                
            } else {
                openLoadRequest(url: url)
                return false
            }
        }
        return true
    }
    
    func onBackPressed() {
        print("back pressed")
        hideBackButton()
        webView.goBack()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        ProgressBarView.showHUD()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        ProgressBarView.hideHUD()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        let alert = UIAlertController(title: error.localizedDescription, message: "", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: { action in ProgressBarView.hideHUD() })
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openAppWithUrlScheme(scheme: String, url: URL) {
        if scheme == "tel" {
            validateToOpenUrl(url: url)
            
        } else if scheme == "mailto" {
            validateToOpenUrl(url: url)
        } else {
            return
        }
    }
    
    func validateToOpenUrl(url: URL) {
        UIApplication.shared.openURL(url)
    }
    
    func showBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(ViewController.onBackPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func hideBackButton() {
        self.navigationItem.leftBarButtonItem = nil
    }
}
