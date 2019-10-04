//
//  AppleSignInWrapper.swift
//  TestApp
//
//  Created by Shmuel, Sagi on 07/08/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import Foundation
import Gigya
import AuthenticationServices

@available(iOS 13.0, *)
class AppleSignInWrapper: NSObject, ProviderWrapperProtocol {
    var clientID: String?

    lazy var appleIDProvider: ASAuthorizationAppleIDProvider = {
        return ASAuthorizationAppleIDProvider()
    }()

    weak var viewController: UIViewController?

    private var completionHandler: (_ jsonData: [String: Any]?, _ error: String?) -> Void = { _, _  in }

    required override init() {
        super.init()

    }

    func login(params: [String : Any]?, viewController: UIViewController?, completion: @escaping ([String : Any]?, String?) -> Void) {
        self.completionHandler = completion
        self.viewController = viewController

        let appleIDProvider = ASAuthorizationAppleIDProvider()

        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

@available(iOS 13.0, *)
extension AppleSignInWrapper: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            if let authorizationCode = appleIDCredential.authorizationCode, let identityToken = appleIDCredential.identityToken {

                let authorizationCodeEncoded = String(decoding: authorizationCode, as: UTF8.self)
                let identityTokenEncoded = String(decoding: identityToken, as: UTF8.self)

                var jsonData: [String: Any] = ["code": authorizationCodeEncoded, "accessToken": identityTokenEncoded]

                if let firstName = appleIDCredential.fullName?.givenName {
                    jsonData["firstName"] = firstName
                }

                if let lastName = appleIDCredential.fullName?.familyName {
                    jsonData["lastName"] = lastName
                }

                completionHandler(jsonData, nil)
            } else {
                completionHandler(nil, "can't getting params from Apple")
            }

        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        completionHandler(nil, error.localizedDescription)
    }
}

@available(iOS 13.0, *)
extension AppleSignInWrapper: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.viewController!.view.window!
    }
}
