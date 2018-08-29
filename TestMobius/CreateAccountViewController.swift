//
//  CreateAccountViewController.swift
//  TestMobius
//
//  Created by Sajid Nawaz on 8/29/18.
//  Copyright © 2018 Sajid Nawaz. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var publickeytxtfield: UITextField!
    @IBOutlet weak var secretkeytxtfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createbtntpd(_ sender: Any)
    {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
         let account = StellarSDK.Account.random()
        account.useNetwork(.test)
        account.useTestNetwork()
        account.friendbot { (true) in
            account.getInfo { response in
                print(response.balances)
                DispatchQueue.main.async {
                    self.publickeytxtfield.text = account.publicKey
                    self.secretkeytxtfield.text = account.secretKey
                    alert.dismiss(animated: false, completion: nil)
                }
                
            }
        }
        
        
    }
    
    
    @IBAction func backbtntpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
