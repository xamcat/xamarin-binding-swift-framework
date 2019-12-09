//
//  ViewController.swift
//  Swift.SingleView
//
//  Created by Alexey Strakh on 10/4/19.
//  Copyright © 2019 Xamarin. All rights reserved.
//

import UIKit
import Gigya
import SwiftFrameworkProxy

class ViewController: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnLoginWithGigya: UIButton!
    @IBOutlet weak var btnLoginWithProxy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLoginWithGigya.addTarget(self, action: #selector(self.btnLoginWithGigya_Tap), for: .touchUpInside)
        btnLoginWithProxy.addTarget(self, action: #selector(self.btnLoginWithProxy_Tap), for: .touchUpInside)
      }

    @objc func btnLoginWithGigya_Tap(sender: UIButton!) {
        // init
        Gigya.sharedInstance().initFor(apiKey: "APIKey");
        let gigyaDomain = Gigya.sharedInstance().config.apiDomain
        let result = "Gigya initialized with domain: \(gigyaDomain)"
        lblMessage.text = result;
        
        // activate login
        Gigya.sharedInstance().login(
                   with: GigyaSocialProviders.google,
                   viewController: self,
                   completion: { _ in
                       // Gigya.login.completed
                   })
    }
    
    @objc func btnLoginWithProxy_Tap(sender: UIButton!) {
        // init
        let proxy = SwiftFrameworkProxy()
        let result = proxy.initFor(apiKey: "APIKey")
        
        // activate login
        lblMessage.text = result;
        proxy.login(
            provider: GigyaSocialProvidersProxy.google,
            viewController: self,
            completion: { (_, _) in
               // Gigya.login.completed
        });
      }
}

