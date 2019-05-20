//
//  Utils.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/21/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    static let sharedInstance: Utils = Utils()
    
    
    public func setupAppearences() {
        self.setupNavigationBarAppearence()
    }
    
    
    private func setupNavigationBarAppearence() {
        let navBar = UINavigationBar.appearance()
        if let font = UIFont.init(name: "Montserrat-Bold", size: 24) {
            navBar.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.red]
        }
        navBar.backIndicatorImage = UIImage.init(named: "backArrow")
        navBar.backIndicatorTransitionMaskImage = UIImage.init(named: "backArrow")
        #warning("set tint color to F62F5E instead of red")
        navBar.tintColor = UIColor.red
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)
    }

}
