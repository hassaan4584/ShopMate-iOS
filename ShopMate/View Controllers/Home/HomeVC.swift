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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.homeTableview.tableFooterView = UIView()
        
        self.fetchProducts()
        
    }
    
    
    
    func fetchProducts() {
        NetworkManager.sharedInstance.getProducts { (productsArr, errStr)  in
            if errStr != nil {
                print(errStr)
            } else {
                print(productsArr)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 648 * (UIScreen.main.bounds.width/320)
        }
        else if indexPath.row == 1 {
            return 320 * (UIScreen.main.bounds.width/320)
        }
        else if indexPath.row == 2 {
            return 100 * (UIScreen.main.bounds.width/320)
        }
        else if indexPath.row == 3 {
            return 346 * (UIScreen.main.bounds.width/320)
        }
        else if indexPath.row == 4 {
            return 346 * (UIScreen.main.bounds.width/320)
        }
        
        return 648 * (UIScreen.main.bounds.width/320)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "MainBannerTVCell") as! MainBannerTVCell
        }
        else if indexPath.row == 1 {
            return tableView.dequeueReusableCell(withIdentifier: "AutumnTVCell") as! AutumnTVCell
        }
        else if indexPath.row == 2 {
            return tableView.dequeueReusableCell(withIdentifier: "MenShirtTVCell") as! MenShirtTVCell
        }
        else if indexPath.row == 3 {
            return tableView.dequeueReusableCell(withIdentifier: "HotTVCell") as! HotTVCell
        }
        else if indexPath.row == 4 {
            return tableView.dequeueReusableCell(withIdentifier: "ColorSelectionTVCell") as! ColorSelectionTVCell
        }
        
        return UITableViewCell()
    }

}
