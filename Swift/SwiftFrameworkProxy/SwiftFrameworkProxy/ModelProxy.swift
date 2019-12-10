//
//  Structs.swift
//  SwiftFrameworkProxy
//
//  Created by Alexey Strakh on 10/17/19.
//  Copyright © 2019 Xamarin. All rights reserved.
//

import Foundation
import Gigya

@objc(GigyaSocialProvidersProxy)
public enum GigyaSocialProvidersProxy: Int {
    case facebook
    case google
    case apple
    case twitter
    case yahoo
    case line
    case wechat
    case amazon
    case blogger
    case foursquare
    case instagram
    case kakao
    case linkedin
    case livedoor
    case messenger
    case mixi
    case naver
    case netlog
    case odnoklassniki
    case paypaloauth
    case tencentQq
    case renren
    case sinaWeibo
    case spiceworks
    case vkontakte
    case wordpress
    case xing
    case yahooJapan
    
    func toGigyaSocialProviders() -> GigyaSocialProviders {
        switch self {
            case GigyaSocialProvidersProxy.facebook:
                return GigyaSocialProviders.facebook
            case GigyaSocialProvidersProxy.google:
                return GigyaSocialProviders.google
            case GigyaSocialProvidersProxy.twitter:
                return GigyaSocialProviders.twitter
            case GigyaSocialProvidersProxy.yahoo:
                return GigyaSocialProviders.yahoo
            case GigyaSocialProvidersProxy.apple:
                return GigyaSocialProviders.apple
            case GigyaSocialProvidersProxy.line:
                return GigyaSocialProviders.line
            case GigyaSocialProvidersProxy.wechat:
                return GigyaSocialProviders.wechat
            case GigyaSocialProvidersProxy.amazon:
                return GigyaSocialProviders.amazon
            case GigyaSocialProvidersProxy.blogger:
                return GigyaSocialProviders.blogger
            case GigyaSocialProvidersProxy.foursquare:
                return GigyaSocialProviders.foursquare
            case GigyaSocialProvidersProxy.instagram:
                return GigyaSocialProviders.instagram
            case GigyaSocialProvidersProxy.kakao:
                return GigyaSocialProviders.kakao
            case GigyaSocialProvidersProxy.linkedin:
                return GigyaSocialProviders.linkedin
            case GigyaSocialProvidersProxy.livedoor:
                return GigyaSocialProviders.livedoor
            case GigyaSocialProvidersProxy.messenger:
                return GigyaSocialProviders.messenger
            case GigyaSocialProvidersProxy.mixi:
                return GigyaSocialProviders.mixi
            case GigyaSocialProvidersProxy.naver:
                return GigyaSocialProviders.naver
            case GigyaSocialProvidersProxy.netlog:
                return GigyaSocialProviders.netlog
            case GigyaSocialProvidersProxy.odnoklassniki:
                return GigyaSocialProviders.odnoklassniki
            case GigyaSocialProvidersProxy.paypaloauth:
                return GigyaSocialProviders.paypaloauth
            case GigyaSocialProvidersProxy.tencentQq:
                return GigyaSocialProviders.tencentQq
            case GigyaSocialProvidersProxy.renren:
                return GigyaSocialProviders.renren
            case GigyaSocialProvidersProxy.sinaWeibo:
                return GigyaSocialProviders.sinaWeibo
            case GigyaSocialProvidersProxy.spiceworks:
                return GigyaSocialProviders.spiceworks
            case GigyaSocialProvidersProxy.vkontakte:
                return GigyaSocialProviders.vkontakte
            case GigyaSocialProvidersProxy.wordpress:
                return GigyaSocialProviders.wordpress
            case GigyaSocialProvidersProxy.xing:
                return GigyaSocialProviders.xing
            case GigyaSocialProvidersProxy.yahooJapan:
                return GigyaSocialProviders.yahooJapan
        }
    }
}

@objc(GigyaAccountProxy)
public class GigyaAccountProxy : NSObject {
    @objc
    public var lastLogin: String?
    
    static func fromGigyaAccount(source: GigyaAccount) -> GigyaAccountProxy {
        let result = GigyaAccountProxy()
        result.lastLogin = source.lastLogin

        return result;
    }
}


@objc(NetworkErrorProxy)
public class NetworkErrorProxy : NSObject {
    @objc
    public var errorMessage: String?
    
    static func fromNetworkError(source: NetworkError) -> NetworkErrorProxy {
        let error = NetworkErrorProxy()
        switch source {
           case NetworkError.gigyaError(let gigyaError):
               error.errorMessage = gigyaError.errorMessage
               break;
           case NetworkError.networkError(let networkError):
               error.errorMessage = networkError.localizedDescription
               break;
           case NetworkError.providerError(let providerError):
               error.errorMessage = providerError.description
               break;
           case NetworkError.emptyResponse:
               error.errorMessage = "empty error"
               break;
           case NetworkError.jsonParsingError(let jsonError):
               error.errorMessage = jsonError.localizedDescription
               break;
           case NetworkError.createURLRequestFailed:
               error.errorMessage = "create URL Request Failed"
               break;
        }
        
        return error;
    }
}
