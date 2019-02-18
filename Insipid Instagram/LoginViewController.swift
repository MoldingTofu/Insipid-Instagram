//
//  LoginViewController.swift
//  Insipid Instagram
//
//  Created by jeremy on 2/17/19.
//  Copyright © 2019 Jeremy Chang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
//        let username = usernameField.text!
//        let password = passwordField.text!
//
//        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
//            if error != nil {
//                print(error?.localizedDescription as Any)
//            }
//            else {
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            }
//        }
        self.performSegue(withIdentifier: "loginSegue", sender:  nil)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
//        let user = PFUser()
//        user.username = usernameField.text
//        user.password = passwordField.text
//
//        user.signUpInBackground { (success, error) in
//            if error != nil {
//                print(error?.localizedDescription as Any)
//            }
//            else {
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            }
//        }
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
