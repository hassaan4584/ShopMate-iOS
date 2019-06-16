//
//  Prodouct.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/18/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import Foundation


// MARK: ProdcutContainer Model
struct ProductContainer: Decodable {
    let totalProductsCount  : Int
    let productsList        : [Product]
    
    enum ProductContainerCodingKeys: String, CodingKey {
        case totalProductCount  = "count"
        case productList        = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductContainerCodingKeys.self)
        totalProductsCount = try container.decode(Int.self, forKey: .totalProductCount)
        productsList = try container.decode([Product].self, forKey: .productList)
    }
}

// MARK: Product Model
struct Product: Decodable {
    let productId       : Int
    let productName     : String
    let productDesc     : String
    let price           : String
    let discountedPrice : String
    let thumbnail       : String
    
    enum ProductCodingKeys: String, CodingKey {
        case productId      = "product_id"
        case productName    = "name"
        case productDesc    = "description"
        case price          = "price"
        case discountedPrice = "discounted_price"
        case thumbnail      = "thumbnail"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        productId       = try container.decode(Int.self, forKey: .productId)
        productName     = try container.decode(String.self, forKey: .productName)
        productDesc     = try container.decode(String.self, forKey: .productDesc)
        price           = try container.decode(String.self, forKey: .price)
        discountedPrice = try container.decode(String.self, forKey: .discountedPrice)
        thumbnail       = try container.decode(String.self, forKey: .thumbnail)
    }
    
    
    var productPriceStr: String {
        get {
            return "£" + price
        }
    }
}

