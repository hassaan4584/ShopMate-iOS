//
//  ProductAttributes.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 6/16/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import Foundation

// MARK: - ProductAttribute
struct ProductAttribute: Codable {
    let attributeName: String
    let attributeValueID: Int
    let attributeValue: String
    
    enum CodingKeys: String, CodingKey {
        case attributeName = "attribute_name"
        case attributeValueID = "attribute_value_id"
        case attributeValue = "attribute_value"
    }
}

typealias ProductAttributesList = [ProductAttribute]
