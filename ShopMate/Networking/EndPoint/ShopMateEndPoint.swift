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
    case generateUniqueCartId
    case addProductToCart(Parameters?)
    
    case products(Parameters?)
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
        case .generateUniqueCartId:
            return "shoppingcart/generateUniqueId"
        case .addProductToCart(_):
            return "shoppingcart/add"
            
        case .products(_):
            return "products"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .addProductToCart(_):
            return .post
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .homepage, .generateUniqueCartId:
            return .request
        case .products(let params), .addProductToCart(let params):
            return .requestParameters(bodyParameters: nil, bodyEncoding: ParameterEncoding.urlAndJsonEncoding, urlParameters: params)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


