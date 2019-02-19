//
//  LoginViewController.swift
//  Insipid Instagram
//
//  Created by jeremy on 2/17/19.
//  Copyright © 2019 Jeremy Chang. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class LoginViewController: UIViewController {

    var db: Firestore!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func onSignIn(_ sender: Any) {
        let email = usernameField.text!
        let password = passwordField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if error != nil {
                self?.errorLabel.text = "Error logging in."
                print(error?.localizedDescription as Any)
            }
            else {
                self?.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
        self.performSegue(withIdentifier: "loginSegue", sender:  nil)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let email = usernameField.text!
        let password = passwordField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.errorLabel.text = "Error creating account."
                print(error?.localizedDescription as Any)
            }
            else {
                self.errorLabel.text = ""
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
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

}
