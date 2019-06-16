//
//  ProductAttributes.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 6/16/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import Foundation
import UIKit

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
    
    var attributeColor: UIColor {
        if let color = ProductAttributeColor.init(rawValue: self.attributeValue) {
            return UIColor.colorWithHex(color.colorHexCode)
        } else {
            return UIColor.darkGray
        }
    }
}

// MARK : Product Attribute List
typealias ProductAttributesList = [ProductAttribute]

extension ProductAttributesList {
    
    var productColorAttributes: [ProductAttribute] {
        get {
            let list = self.filter( {$0.attributeName.lowercased() == "color"})
            return list
        }
    }
    
    var productSizeAttributes: [ProductAttribute] {
        get {
            let sizeList = self.filter({$0.attributeName.lowercased() == "size"})
            return sizeList
        }
    }
    
}

// MARK : Colors
enum ProductAttributeColor: String {
    case black      = "Black"
    case indigo     = "Indigo"
    case blue       = "Blue"
    case red        = "Red"
    case orange     = "Orange"
    case yellow     = "Yellow"
    case green      = "Green"
    case purple     = "Purple"
    case white      = "White"
    
    var colorHexCode: String {
        switch self {
        case .black:
            return "#000000"
        case .indigo:
            return "#6EB2FB"
        case .blue:
            return "#00D3CA"
        case .red:
            return "#F62F5E"
        case .orange:
            return "#FE5C07"
        case .yellow:
            return "#F8E71C"
        case .green:
            return "#7ED321"
        case .purple:
            return "#9013FE"
        case .white:
            return "#FFFFFF"
        }
    }
}
