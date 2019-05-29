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

// MARK: Cart Model
typealias CartContainer = [Product]
    

