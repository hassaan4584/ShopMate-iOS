//
//  CartManager.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/28/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import UIKit

class CartManager: NSObject {
    
    static let sharedInstance: CartManager = CartManager()
    
    var cartId: String?
    var cart: Cart?
    
    
    func generateCartUniqueId(_ onComplete: @escaping(_ id: String?) -> ()) {
        NetworkManager.sharedInstance.generateUniqueCartId { [weak self] (uniqueId, errStr) in
            if let errStr = errStr {
                print(errStr)
                onComplete(nil)
            } else {
                self?.cartId = uniqueId
                onComplete(uniqueId)
            }
        }
    }
    
    func addProductToCart(_ product: Parameters, _ onComplete: @escaping() -> Void) {
        var productDetails = product
        let addProductBlock = {
            NetworkManager.sharedInstance.addProductToCart(productDetails) { [weak self] (products, errStr) in
                if let errStr = errStr {
                    print(errStr)
                    onComplete()
                } else {
                    self?.cart = products
                    onComplete()
                }
            }
        }

        if !self.isCartInitialized { // If cart is not initialised
            self.generateCartUniqueId { (id) in
                if let id = id {
                    productDetails["cart_id"] = id
                    addProductBlock()
                } else {
                    onComplete()
                }
            }
        } else { // If Cart unique Id is already present
            productDetails["cart_id"] = self.cartId ?? ""
            addProductBlock()
        }
    }
    
    
    
    

}

extension CartManager {
    
    var isCartInitialized: Bool {
        get {
            return self.cartId != nil
        }
    }
}
