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
    
    //public func login(with provider: Gigya.GigyaSocialProviders, viewController: UIViewController, params: [String : Any] = [:], completion: @escaping (Gigya.GigyaLoginResult<T>) -> Void)
    @objc
    public func login(provider: GigyaSocialProvidersProxy, viewController: UIViewController, completion: @escaping (GigyaAccountProxy?, NetworkErrorProxy?) -> Void) {

        // 1. don't use `with` keyword because it's translated to objC which couldn't be understand out of the box by the sharpie
        // 2. have to re-created all non Int based enum because others couldn't be translated to ObjC automatically
        // 3. don't use `generics` in the func declaration because it's not compatible with ObjC
        // 4. unable to use Gigya's structs, have to recreate a proxy classes for every struct you want to access in ObjC
        
        Gigya.sharedInstance().login(
            with: provider.toGigyaSocialProviders(),
            viewController: viewController,
            completion: { result in
                switch result {
                    case .success(let data):
                        let resultProxy = GigyaAccountProxy.fromGigyaAccount(source: data);
                        completion(resultProxy, nil)
                        break;
                    case .failure(let data):
                        let error = NetworkErrorProxy.fromNetworkError(source: data.error)
                        completion(nil, error);
                        break;
                }
        })
    }
}
