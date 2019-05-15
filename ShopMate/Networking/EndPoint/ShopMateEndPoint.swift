//
//  ShopMateEndPoint.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/15/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case production
    case staging
}

public enum ShopMateApi {
    
    case homepage
}

extension ShopMateApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://mobilebackend.turing.com" // Production URL
        case .staging: return "" // Staging URL
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
            case .homepage:
                return "mobileHomePage"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .homepage:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


