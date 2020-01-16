//
//  ViewController.swift
//  market
//
//  Created by Ahmed Saeed on 11/28/19.
//  Copyright © 2019 AhmedSaeed. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
class ViewController: UIViewController,LoginButtonDelegate{
    
    @IBOutlet weak var Login_button: FBLoginButton!
    
    
   


    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        Login_button.delegate = self
        Login_button.permissions = ["email"]
    }


    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error == nil
        {
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print(authResult?.user.email as Any)
            }
        }
        else
        {
            print(error?.localizedDescription as Any)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("user logged out")
    }
    
    
    
    
    }



