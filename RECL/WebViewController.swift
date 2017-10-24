//
//  WebViewController.swift
//  RECL
//
//  Created by admin on 24/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    let loader = UIActivityIndicatorView()
    @IBOutlet weak var webView: UIWebView!
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        let url = URL(string: self.url!)
        openLoadRequest(url: url!)
    }
        
    func openLoadRequest(url: URL) {
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
}

extension WebViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if let url = request.url {
            openLoadRequest(url: url)
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
        
        let alert = UIAlertController(title: error.localizedDescription, message: "", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: { action in self.stopLoading() })
        
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
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
