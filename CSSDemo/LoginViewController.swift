//
//  LoginViewController.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 17.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit
import InstagramKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var webView: UIWebView!
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instagramEngine = InstagramEngine.sharedEngine()
        let appClientID = NSUserDefaults.standardUserDefaults().stringForKey("InstagramAppClientId")
        let appRedirectURL = NSUserDefaults.standardUserDefaults().stringForKey("InstagramAppRedirectURL")
        let appSecret = "7b11992a61ec4081a90e1a4a016d4202"
        
        let url = instagramEngine.authorizarionURLForScope(.Basic)
//        let url = "https://instagram.com/oauth/authorize/?client_id=[Client ID]&redirect_uri=[Redirect URI]&response_type=token"
        let request = NSURLRequest(URL: url)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension LoginViewController: UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        var error: NSError? = nil
        if InstagramEngine.sharedEngine().extractValidAccessTokenFromURL(request.URL, error: &error) {
            self.performSegueWithIdentifier("unwindLoginSegue", sender: self)
        } else if error != nil {
            NSLog("Error extracting access token: \(error)")
        }
        
        return true;
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        NSLog("Error loading page: \(error)")
    }
    
}
