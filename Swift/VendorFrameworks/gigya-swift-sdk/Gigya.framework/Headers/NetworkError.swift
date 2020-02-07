//
//  APIServiceError.swift
//  GigyaSwift
//
//  Created by Shmuel, Sagi on 04/03/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import Foundation

@frozen
public enum NetworkError: Error {
    case gigyaError(data: GigyaResponseModel)
    case providerError(data: String)
    case networkError(error: Error)
    case emptyResponse
    case jsonParsingError(error: Error)
    case createURLRequestFailed
}
