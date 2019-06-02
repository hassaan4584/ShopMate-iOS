//
//  NetworkManager.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/15/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case methodNotAllowed = "Method Not Allowed" // make sure correct GET and POST methods are used
    case internalServerError = "Internal Server Error"
}

enum Result<String> {
    case success
    case failure(String)
}

fileprivate let DEFAULT_NETWORK_ERROR: String = "Please check your network connection."

struct NetworkManager {
    static let sharedInstance: NetworkManager = NetworkManager()
    static var environment : NetworkEnvironment = .production
    let router = Router<ShopMateApi>()
    

    
    func getHomePage(completion: @escaping (_ homePagedata: String?,_ error: String?)->()) {
        let homepageRequest = ShopMateApi.homepage
        router.request(homepageRequest) { data, response, error in
            
            if error != nil {
                completion(nil, error?.localizedDescription ?? DEFAULT_NETWORK_ERROR)
                return
            }
       
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        print("completion(nil, NetworkResponse.noData.rawValue)")
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(String.self, from: responseData)
                        print("completion(apiResponse.homepage_sections,nil)")
                        completion(apiResponse, nil)
                        return
                    } catch {
                        print("completion(nil, NetworkResponse.unableToDecode.rawValue)")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func generateUniqueCartId(_ completion: @escaping (_ cartId: String?, _ error: String?) -> ()) {
        let uniqueIdRequest = ShopMateApi.generateUniqueCartId
        self.router.request(uniqueIdRequest) { (data, response, error) in
            
            if error != nil {
                completion(nil, error?.localizedDescription ?? DEFAULT_NETWORK_ERROR)
                return
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        print("completion(nil, NetworkResponse.noData.rawValue)")
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(UniqueCartIDContainer.self, from: responseData)
                        completion(apiResponse.cartID, nil)
                        return
                    } catch {
                        print("completion(nil, NetworkResponse.unableToDecode.rawValue)")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func addProductToCart(_ parameters: Parameters, _ completion: @escaping (_ products: Cart?, _ error: String?) -> ()) {
        let addToCartRequest = ShopMateApi.addProductToCart(parameters)
        self.router.request(addToCartRequest) { (data, response, error) in
            
            if error != nil {
                completion(nil, error?.localizedDescription ?? DEFAULT_NETWORK_ERROR)
                return
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let productsArr = try JSONDecoder().decode(Cart.self, from: responseData)
                        completion(productsArr, nil)
                        return
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    // MARK: Products
    
    func getProducts(_ queryParams: Parameters? = nil, completion: @escaping (_ productsData: ProductContainer?, _ error: String?) -> ()) {
        let productsRequest = ShopMateApi.products(queryParams)
        self.router.request(productsRequest) { data, response, error in

            if error != nil {
                completion(nil, error?.localizedDescription ?? DEFAULT_NETWORK_ERROR)
                return
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        print("completion(nil, NetworkResponse.noData.rawValue)")
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(ProductContainer.self, from: responseData)
                        print("completion(apiResponse.homepage_sections,nil)")
                        completion(apiResponse, nil)
                        return
                    } catch {
                        print("completion(nil, NetworkResponse.unableToDecode.rawValue)")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 405: return .failure("\(response.statusCode) " + NetworkResponse.methodNotAllowed.rawValue)
        case 500: return .failure("\(response.statusCode) " + NetworkResponse.internalServerError.rawValue)
        case 401...500: return .failure("\(response.statusCode) " + NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure("\(response.statusCode) " + NetworkResponse.badRequest.rawValue)
        case 600: return .failure("\(response.statusCode) " + NetworkResponse.outdated.rawValue)
        default: return .failure("\(response.statusCode) " + NetworkResponse.failed.rawValue)
        }
    }
    
}

