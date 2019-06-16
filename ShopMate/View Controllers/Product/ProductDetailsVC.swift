//
//  ProductDetailsVC.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/20/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var ratingsStackView: UIStackView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productColorOptionsStackView: UIStackView!
    @IBOutlet weak var productSizeOptionsStackView: UIStackView!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    var product: Product?
    var productAttributes: ProductAttributesList?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.productQuantityLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.navigationItem.titleView = UIImageView.init(image: UIImage(named: "title"))

        if let product = self.product {
            NetworkManager.sharedInstance.getProductAttributes(product.productId) { (attributesList, errStr) in
                if let errStr = errStr {
                    print(errStr)
                } else {
//                    self.productAttributes = attributesList
                }
            }
        }
        self.displayProductData()
        
    }
    
    
    func displayProductData() {
        self.productNameLabel.text  = self.product?.productName
        self.productPriceLabel.text = self.product?.productPriceStr
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func addProductToCart() {
        guard self.product != nil else {
            return
        }
        Spinner.sharedInstance.show(onViewController: self)
        let params: Parameters = ["product_id": self.product!.productId, "attributes": "White"]
        CartManager.sharedInstance.addProductToCart(params) {
            Spinner.sharedInstance.hide(from: self)
        }
    }
    
    
    // MARK: User Interaction
    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
        self.addProductToCart()
    }
}
