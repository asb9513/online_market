//
//  itemViewController.swift
//  market
//
//  Created by Ahmed Saeed on 12/2/19.
//  Copyright © 2019 AhmedSaeed. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class itemViewController: UIViewController {
    var item : product?
    @IBOutlet weak var product_price: UILabel!
    @IBOutlet weak var product_detail: UITextView!
    @IBOutlet weak var product_imag: UIImageView!
   
    @IBOutlet weak var product_name: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        product_price.text = item?.productprice
        product_name.text = item?.productName
        product_detail.text = item?.productDescription
        Alamofire.request((item?.productphotophoto)!).responseImage { response in
            
            if let image = response.result.value {
                
                self.product_imag.image = image
                
            }
        }
        
 }
    @IBAction func buy(_ sender: Any) {
       
        // open buy view controller
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)

        let buyVC = mainStoryBoard.instantiateViewController(withIdentifier: "buyVC") as! BuyingViewController
        
        buyVC.item = self.item
        
        self.present(buyVC, animated: true, completion: nil)

        	


    }
}
