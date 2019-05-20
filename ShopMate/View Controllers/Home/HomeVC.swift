//
//  HomeVC.swift
//  ShopMate
//
//  Created by Hassaan Fayyaz Ahmed on 5/17/19.
//  Copyright © 2019 Hassaan Fayyaz Ahmed. All rights reserved.
//

import UIKit

enum HomeTVCell: String {
    case mainBannerTVCell       = "mainBannerTVCell"
    case autumnTVCell           = "autumnTVCell"
    case menShirtTVCell         = "menShirtTVCell"
    case hotTVCell              = "hotTVCell"
    case colorSelectionTVCell   = "colorSelectionTVCell"
}

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var homeTableview: UITableView!
    
    var productsData: ProductContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.homeTableview.tableFooterView = UIView()
        self.setupNavigationBar()

        self.fetchProducts()
        
    }
    
    // MARK: UI
    func setupNavigationBar() {
        self.navigationItem.titleView = UIImageView.init(image: UIImage(named: "title"))
        // button
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        rightButton.setBackgroundImage(UIImage(named: "navBarMenu"), for: .normal)
        rightButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        
        // Bar button item
        let rightBarButtomItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightBarButtomItem
        
        print(navigationItem.leftBarButtonItem)
        print(navigationItem.backBarButtonItem)
    }
    
    
    // MARK: Navigator
    @objc func menuButtonPressed() {
        
    }
    
    // MARK: Api Calls
    func fetchProducts() {
        Spinner.sharedInstance.show(onViewController: self)
        
        NetworkManager.sharedInstance.getProducts { [weak self] (productsArr, errStr)  in
            if self != nil { Spinner.sharedInstance.hide(from: self!) }
            if errStr != nil {
                print(errStr!)
            } else {
                self?.productsData = productsArr
                self?.homeTableview.reloadData()
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ProductDetailSegue" , let productVC = segue.destination as? ProductDetailsVC {
            if let indexPath = self.homeTableview.indexPathForSelectedRow {
                productVC.product = self.productsData?.productsList[indexPath.row]
            }
        }
    }
    
    // MARK: Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsData?.productsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 346
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HotTVCell") as! HotTVCell
        cell.product = self.productsData?.productsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ProductDetailSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
