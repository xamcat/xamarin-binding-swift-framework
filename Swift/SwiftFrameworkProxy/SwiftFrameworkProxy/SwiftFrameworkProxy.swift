//
//  SwiftFrameworkProxy.swift
//  SwiftFrameworkProxy
//
//  Created by Alexey Strakh on 10/4/19.
//  Copyright © 2019 Xamarin. All rights reserved.
//

import Foundation
import UIKit
import Gigya

@objc(SwiftFrameworkProxy)
public class SwiftFrameworkProxy : NSObject {

    @objc
    public func initFor(apiKey: String) -> String {
        Gigya.sharedInstance().initFor(apiKey: apiKey)
        let gigyaDomain = Gigya.sharedInstance().config.apiDomain
        let result = "!!! Gigya initialized with domain: \(gigyaDomain)"
        return result
    }
    
    //with provider: Gigya.GigyaSocialProviders, viewController: UIViewController, params: [String : Any] = [:], completion: @escaping (Gigya.GigyaLoginResult<T>) -> Void
    @objc
    public func login(with provider: GigyaSocialProvidersProxy, viewController: UIViewController) {

        Gigya.sharedInstance().login(
            with: provider.toGigyaSocialProviders(),
            viewController: viewController,
            completion: { _ in
                // Gigya.login.completed
            })
    }
}
