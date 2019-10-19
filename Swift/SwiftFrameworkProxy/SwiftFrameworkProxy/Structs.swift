//
//  Structs.swift
//  SwiftFrameworkProxy
//
//  Created by Alexey Strakh on 10/17/19.
//  Copyright © 2019 Xamarin. All rights reserved.
//

import Foundation
import Gigya

@objc
public enum GigyaSocialProvidersProxy: Int {
    case facebook
    case google
    case apple
    case twitter
    case yahoo
    
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
            default:
                return GigyaSocialProviders.apple
        }
    }
}

//struct GigyaSocialProviderTypes {
//    static let facebook = "facebook"
//    static let google = "google"
//    static let yahoo = "yahoo"
//    static let twitter = "twitter"
//    static let line = "line"
//    static let wechat = "wechat"
//    static let amazon = "amazon"
//    static let blogger = "blogger"
//    static let foursquare = "foursquare"
//    static let instagram = "instagram"
//    static let kakao = "kakao"
//    static let linkedin = "linkedin"
//    static let livedoor = "livedoor"
//    static let messenger = "messenger"
//    static let mixi = "mixi"
//    static let naver = "naver"
//    static let netlog = "netlog"
//    static let odnoklassniki = "odnoklassniki"
//    static let orangeFrance = "orangeFrance"
//    static let paypaloauth = "paypaloauth"
//    static let tencentQq = "tencentQq"
//    static let renren = "renren"
//    static let sinaWeibo = "sinaWeibo"
//    static let spiceworks = "spiceworks"
//    static let vkontakte = "vkontakte"
//    static let wordpress = "wordpress"
//    static let xing = "xing"
//    static let yahooJapan = "yahooJapan"
//    static let apple = "apple"
//}
