//
//  ViewController.swift
//  instagram
//
//  Created by carlnnaji on 7/23/17.
//  Copyright © 2017 carlnnaji. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

   var signupModeActive = true
    
    func displayAlert(title:String, message:String) {
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    
    
    }
    
    @IBOutlet var email: UITextField!
    
    
    @IBOutlet var password: UITextField!
    
    
    @IBAction func signupOrLogin(_ sender: Any) {
        
        
        if email.text == "" || password.text == "" {
        
            self.displayAlert(title: "Error in form", message: "Please enter an email and password")
            
        
        } else {
            
            
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityIndicator.center = self.view.center
            
            activityIndicator.hidesWhenStopped = true
            
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            
            
            view.addSubview(activityIndicator)
            
            
            activityIndicator.startAnimating()
            
            
            UIApplication.shared.beginIgnoringInteractionEvents()
        
      
        
        if (signupModeActive) {
            
            // if signupMode is active user should signup otherwise user should login
            let user = PFUser()
            user.username = email.text
            user.password = password.text
            user.email = email.text
           
            user.signUpInBackground(block: { (success, error) in
                
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if let error = error {
                    
                    // let errorString = error.userInfo["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                    
                    self.displayAlert(title: "Could not sign you up", message: error.localizedDescription)
                    
                    print(error)
                    
                } else {
                
                    print("Signed Up")
                    
                    self.performSegue(withIdentifier: "showUserTable", sender: "self")
                
                }
                
            })
            
      
        } else {
            
            
             PFUser.logInWithUsername(inBackground: email.text!, password: password.text!, block: { (user, error) in
                
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if user != nil {
                
                
                    print("login success")
                    
                    self.performSegue(withIdentifier: "showUserTable", sender: "self")
                    
                    
                } else {
                    
                    var errorText = "Unknown error: please try again"
                    
                    if let error = error {
                    
                        errorText = error.localizedDescription
                        
                    }
                    
                
                    self.displayAlert(title: "Could not sign you up", message: errorText)
                
                }
                
             })
            
            }
            
        }

      
        
    }
    
    
    @IBOutlet var signupOrLoginButton: UIButton!
    
    
    @IBAction func switchLoginMode(_ sender: Any) {
        
        if (signupModeActive) {
            
            signupModeActive = false
            
            signupOrLoginButton.setTitle("Login", for: [])
            
            switchLoginModeButton.setTitle("Sign Up", for: [])
            
        } else {
            
            signupModeActive = true
            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            switchLoginModeButton.setTitle("Log In", for: [])
            
            
        }
        
        
    }
    
    
    @IBOutlet var switchLoginModeButton: UIButton!
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
 
        }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
        
            performSegue(withIdentifier: "showUserTable", sender: "self")
            
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
    }

 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

