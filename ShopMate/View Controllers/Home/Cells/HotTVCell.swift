//
//  HotTVCell.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/17/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import UIKit

class HotTVCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel?
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    var product: Product? {
        didSet {
            self.productNameLabel?.attributedText  = NSAttributedString.init(string: product?.productName ?? "")
            self.productPriceLabel.text = product?.price
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
