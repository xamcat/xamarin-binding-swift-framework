//
//  FacebookWrapper.swift
//  GigyaSwift
//
//  Created by Shmuel, Sagi on 23/04/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import Gigya

class FacebookWrapper: NSObject, ProviderWrapperProtocol {

    private var completionHandler: (_ jsonData: [String: Any]?, _ error: String?) -> Void = { _, _  in }

    var clientID: String?

    private let defaultReadPermissions = ["email"]

    lazy var fbLogin: LoginManager = {
        return LoginManager()
    }()

    required override init() {
        super.init()
    }

    func login(params: [String: Any]?, viewController: UIViewController?,
               completion: @escaping (_ jsonData: [String: Any]?, _ error: String?) -> Void) {
        completionHandler = completion

        fbLogin.logIn(permissions: defaultReadPermissions, from: viewController) { (result, error) in
            if result?.isCancelled != false {
                completion(nil, "sign in cancelled")
                return
            }

            if let error = error {
                completion(nil, error.localizedDescription)
            }

            let jsonData: [String: Any] = ["accessToken": result?.token?.tokenString ?? "", "tokenExpiration": result?.token?.expirationDate.timeIntervalSince1970 ?? 0]

            completion(jsonData, nil)
        }
    }

    func logout() {
        fbLogin.logOut()
    }
}
