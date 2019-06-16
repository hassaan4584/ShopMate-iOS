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
    
    @IBOutlet weak var indigoColorAttButton: UIButton!
    @IBOutlet weak var blueColorAttButton: UIButton!
    @IBOutlet weak var redColorAttButton: UIButton!
    @IBOutlet weak var orangeColorAttButton: UIButton!
    @IBOutlet weak var yellowColorAttButton: UIButton!
    @IBOutlet weak var greenColorAttButton: UIButton!
    @IBOutlet weak var purpleColorAttButton: UIButton!

    
    
    
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
                    self.productAttributes = attributesList
                    self.refreshAttributesData()
                }
            }
        }
        self.displayProductData()
        
    }
    
    
    func displayProductData() {
        self.productNameLabel.text  = self.product?.productName
        self.productPriceLabel.text = self.product?.productPriceStr
        
    }
    
    func refreshAttributesData() {
        func addColorAttributes() {
            for (index, attribute) in self.productAttributes!.productColorAttributes.enumerated() {
                if index < self.productColorOptionsStackView.arrangedSubviews.count {
                    self.productColorOptionsStackView.arrangedSubviews[index].backgroundColor = attribute.attributeColor
                    self.productColorOptionsStackView.arrangedSubviews[index].isHidden = false


                }
            }
        }
        
        addColorAttributes()
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
