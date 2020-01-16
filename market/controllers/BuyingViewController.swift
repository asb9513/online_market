//
//  BuyingViewController.swift
//  market
//
//  Created by Ahmed Saeed on 12/3/19.
//  Copyright © 2019 AhmedSaeed. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class BuyingViewController: UIViewController {
    
    var item : product?
    
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            if let product = item {
            self.price.text! = product.productprice
            Alamofire.request((product.productphotophoto)).responseImage { response in
                
                if let image = response.result.value {
                    
                    self.photo.image = image
                    		
                }
            }
            
        }
            
    }
 
}

 


