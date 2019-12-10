//
//  WeChatWrapper.swift
//  GigyaSwift
//
//  Created by Shmuel, Sagi on 02/05/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import UIKit
import Gigya

class WeChatWrapper: ProviderWrapperProtocol {

    var clientID: String? = {
        return Bundle.main.infoDictionary?["WeChatAppID"] as? String
    }()

    private var completionHandler: (_ jsonData: [String: Any]?, _ error: String?) -> Void = { _, _  in }

    required init() {

    }

    func login(params: [String: Any]? = nil, viewController: UIViewController? = nil,
               completion: @escaping (_ jsonData: [String: Any]?, _ error: String?) -> Void) {
        completionHandler = completion
        if WXApi.isWXAppInstalled() == false {
            print("WeChat not installed in the device")
        }

        let request = SendAuthReq.init()
        request.scope = "snsapi_userinfo"
        request.state = ""

        WXApi.send(request)

        WXApi.sendAuthReq(request, viewController: viewController!, delegate: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: Notification.Name("weChatDidReceiveData"), object: nil)

    }

    @objc func onDidReceiveData(_ notification:Notification) {
        // Do something
        let data = notification.object as? [String: Any]

        if let error = data?["error"] as? String {
            completionHandler(nil, error)
            return
        }

        guard let accessToken = data?["accessToken"] else {
            completionHandler(nil, "accessToken not found")
            return
        }

        let jsonData: [String: Any] = ["accessToken": accessToken, "providerUID": clientID ?? ""]

        NotificationCenter.default.removeObserver(self, name: Notification.Name("weChatDidReceiveData"), object: nil)

        completionHandler(jsonData, nil)
    }

    deinit {
        print("deinit wechat")
    }
}

extension AppDelegate: WXApiDelegate {
    func onResp(_ resp: BaseResp) {
        guard resp.errCode == 0, let response: SendAuthResp = resp as? SendAuthResp else {
            let json = ["error": resp.errStr]
            NotificationCenter.default.post(name: Notification.Name("weChatDidReceiveData"), object: json)
            return
        }

        let json = ["accessToken": response.code]
        NotificationCenter.default.post(name: Notification.Name("weChatDidReceiveData"), object: json)

    }
}
