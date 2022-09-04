//
//  APIError.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/04.
//
import Foundation

enum APIError: Error {
    case responseError
    case jsonParseError
    case unknownError

    var message: String {
        switch self {
        case .responseError:
            return "network error"
        case .jsonParseError:
            return "parse error"
        default:
            return "unknown Error"
        }
    }
}
