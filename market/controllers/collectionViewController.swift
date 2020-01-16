//
//  collectionViewController.swift
//  market
//
//  Created by Ahmed Saeed on 11/29/19.
//  Copyright © 2019 AhmedSaeed. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
class collectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
   
    @IBOutlet weak var collectionview: UICollectionView!
     var products : [product] = []
    let urlForMen = URL(string: "https://salemsaber.com/websites/hany/api.php?jackets&fbclid=IwAR1i9WR3EXHOth9kZC5ko_kON_4ChgrcTtYYnGFMWLIOilbHigT9Fsmza3A")
    let urlForWomen = URL(string: "https://salemsaber.com/websites/hany/api.php?women&fbclid=IwAR3ZW1uHmTq_BXle3nBqoluuw9aYuiOrFECdVTwDUO9DFQt_1HDeoglsG-A")
    let urlForWatches = URL(string: "https://salemsaber.com/websites/hany/api.php?watches&fbclid=IwAR0Dxsvbg6JJYV5sW9ZJgevwMgQAkirNrAKow-ILzwX1U4OE0aO4u1OXG4E")
    
   
   
 
    
 

    

    override func viewDidLoad() {
        super.viewDidLoad()
        makerequest(url: urlForMen!)
        makerequest(url: urlForWomen!)
        makerequest(url: urlForWatches!)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mycell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        mycell.name.text = products[indexPath.row].productName
        mycell.desc.text = products[indexPath.row].productDescription
        //with alamofire image
        Alamofire.request(products[indexPath.row].productphotophoto).responseImage { response in
            
            if let image = response.result.value {
                
                mycell.image.image = image
                
            }
        }
        
        return mycell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier:"show", sender: products[indexPath.row])
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let des = segue.destination as? itemViewController
        {
            if let product_item = sender as? product{
                des.item = product_item
            }
            
        }
    }
    //_____________________________________ request_________________
    
    func makerequest(url:URL){
        Alamofire.request(url)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print(error.localizedDescription)
                    
                case .success( let value):
                    
                    let json = JSON(value)
                    json.array?.forEach({(pro) in
                        let pro = product(productName: pro["title"].stringValue, productDescription: pro["description"].stringValue, productphotophoto: pro["image_link"].stringValue, productprice: pro["price"].stringValue)
                        self.products.append(pro)
                      
                    })
                    self.collectionview.reloadData()
                    
                }
        }
    }
    

    
    
}
