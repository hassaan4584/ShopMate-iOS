//
//  Spinner.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/19/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.//

import UIKit

fileprivate let SPINNER_WIDTH: CGFloat = 94
fileprivate let SPINNER_HEIGHT: CGFloat = 56

class Spinner: NSObject {
    
    static let sharedInstance: Spinner = Spinner()

    /* Two separate spiiner objects are used so that hiding spinner from some bacground viewcontroller does not hide spinner from teh actively presented view controller. */
    // Spinner when the View Controller on which Spinner is to be displayed is NOT knwon
    internal static var spinnerViewForWindow: UIImageView?
    
    // Spinner when the View Controller on which Spinner is to be displayed is knwon
    internal var spinnerViewForVC: UIImageView?
    // The UIViewController on whose main view spinner is to be presented
    private var controller: UIViewController?
    private let animationImages: [UIImage] // Sequence of images that will be used to display Spinner

    public override init() {
        let imageNames = (1...30).map {String("Spinner-\($0)")}
        self.animationImages = imageNames.map { UIImage.init(named: $0)! }
        super.init()
    }
    
    public static func show() {
        if spinnerViewForWindow == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            let width: CGFloat = SPINNER_WIDTH
            let height: CGFloat = SPINNER_HEIGHT
            spinnerViewForWindow = UIImageView.init(frame: CGRect.init(x: frame.width/2 - (width/2), y: frame.height/2 - (height/2), width: width, height: height))
            
            let imageNames = (1...30).map {String("Spinner-\($0)")}
            spinnerViewForWindow!.animationImages = imageNames.map { UIImage.init(named: $0)! }

            window.addSubview(spinnerViewForWindow!)
            spinnerViewForWindow!.startAnimating()
        }
    }
    
    public static func hide() {
        if spinnerViewForWindow != nil {
            spinnerViewForWindow?.stopAnimating()
            spinnerViewForWindow?.animationImages?.removeAll()
            spinnerViewForWindow?.removeFromSuperview()
            spinnerViewForWindow = nil
        }
    }

    public func show(onViewController vc:UIViewController) {
        if spinnerViewForVC == nil {
            let frame = vc.view.bounds
            let width: CGFloat = SPINNER_WIDTH
            let height: CGFloat = SPINNER_HEIGHT
            spinnerViewForVC = UIImageView.init(frame: CGRect.init(x: frame.width/2 - (width/2), y: frame.height/2 - (height/2), width: width, height: height))
            
            spinnerViewForVC!.animationImages = self.animationImages
            
        } else if let _ = self.controller {
            spinnerViewForVC?.stopAnimating()
            spinnerViewForVC?.removeFromSuperview()
            self.controller = nil
        }
        
        vc.view.addSubview(spinnerViewForVC!)
        spinnerViewForVC!.startAnimating()
        self.controller = vc
    }
    
    public func hide(from viewController: UIViewController) {
        if spinnerViewForVC != nil && self.controller == viewController {
            spinnerViewForVC?.stopAnimating()
            spinnerViewForVC?.animationImages?.removeAll()
            spinnerViewForVC?.removeFromSuperview()
            spinnerViewForVC = nil
            self.controller = nil
        }
    }
    
    var isLoadingIndicatorShowing: Bool {
        get {
            if let imageView = spinnerViewForVC {
                return imageView.isAnimating
            } else {
                return false
            }
        }
    }

}
