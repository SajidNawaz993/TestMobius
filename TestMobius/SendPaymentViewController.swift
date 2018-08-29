//
//  SendPaymentViewController.swift
//  TestMobius
//
//  Created by Sajid Nawaz on 8/29/18.
//  Copyright © 2018 Sajid Nawaz. All rights reserved.
//

import UIKit

class SendPaymentViewController: UIViewController {
    
    @IBOutlet weak var Sendersecretkeytxtfield: UITextField!
    @IBOutlet weak var receiverpublickeytxtfield: UITextField!
    @IBOutlet weak var totalamounttxtfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Sendersecretkeytxtfield.text = "SB35BOVVOO2XFDEEHYP2JJADZE4X6EGHFUXA4ZYBSWWSZB4GGA5SH3VN"
        receiverpublickeytxtfield.text = "GCSAVWAQ4BXYV2AGFHYZDOTOHZMP3LAZYWP4MBFXU6WBC3KQT5CXAHZF"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendPaymentbtntpd(_ sender: Any) {
        let account = StellarSDK.Account.fromSecret(Sendersecretkeytxtfield.text!)  // Generates the public key from secret key
        account?.useNetwork(.test)
        account?.useTestNetwork()
        
        if(Sendersecretkeytxtfield.text!.isEmpty)
        {
            let alertController = UIAlertController(title: "", message: "Please enter Sender Public Key", preferredStyle:UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            { action -> Void in
                alertController.dismiss(animated: false, completion: nil)
            })
            self.present(alertController, animated: true, completion: nil)
        }
        else if(receiverpublickeytxtfield.text!.isEmpty)
        {
            let alertController = UIAlertController(title: "", message: "Please enter Receiver Secret Key", preferredStyle:UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            { action -> Void in
                alertController.dismiss(animated: false, completion: nil)
            })
            self.present(alertController, animated: true, completion: nil)
        }
        else if(totalamounttxtfield.text!.isEmpty)
        {
            let alertController = UIAlertController(title: "", message: "Please enter Total Amount", preferredStyle:UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            { action -> Void in
                alertController.dismiss(animated: false, completion: nil)
            })
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            self.view.endEditing(true)
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
            account?.payment(address: receiverpublickeytxtfield.text!, amount: (totalamounttxtfield.text! as NSString).doubleValue , memo:"yes", callback: { response in
                print(response.message)
                account?.getBalances(callback: { response  in
                    print((response.first?.balance)!)
                    DispatchQueue.main.async {
                        alert.dismiss(animated: false, completion: nil)
                        let alertController = UIAlertController(title: "", message: "Your balance is "+(response.first?.balance)!, preferredStyle:UIAlertControllerStyle.alert)
                        
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                        { action -> Void in
                            alertController.dismiss(animated: false, completion: nil)
                        })
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                })
            })
        }
        
        
    }
    
    @IBAction func backbtntpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
