//
//  Cart.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import Foundation

// MARK: CartUniqueId Model
struct UniqueCartIDContainer: Codable {
    let cartID: String
    
    private enum CodingKeys: String, CodingKey {
        case cartID = "cart_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cartID = try container.decode(String.self, forKey: .cartID)
    }
}

// MARK: - CartElement
struct CartElement: Codable {
    let itemID, productID, quantity: Int
    let name, attributes, price, subtotal: String
    
    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case productID = "product_id"
        case quantity, name, attributes, price, subtotal
    }
}

typealias Cart = [CartElement]


