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
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.productQuantityLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.displayProductData()
    }
    
    
    func displayProductData() {
        self.productNameLabel.text  = self.product?.productName
        self.productPriceLabel.text = self.product?.price
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
