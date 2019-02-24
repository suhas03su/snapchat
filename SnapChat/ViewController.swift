//
//  ViewController.swift
//  SnapChat
//
//  Created by Faizan Khan on 24/02/19.
//  Copyright © 2019 Faizan Khan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    var signUpMode = false
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    
    @IBAction func topButtonTapped(_ sender: Any) {
        if signUpMode
        {
            if let email = emailTextField.text
            {
                if let password = passwordTextField.text
                {
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if let error = error
                        {
                            self.presentAlertWhenError(alert: error.localizedDescription)
                        }
                        else
                        {
                            self.performSegue(withIdentifier: "snaps", sender: self)
                            print("Sign Up successful")
                        }
                    }
                }
            }
        }
        else
        {
            if let email = emailTextField.text
            {
                if let password = passwordTextField.text
                {
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if let error = error{
                            self.presentAlertWhenError(alert: error.localizedDescription)
                        }
                        else
                        {
                            self.performSegue(withIdentifier: "snaps", sender: self)
                            print("Sign In Successful")
                        }
                    }
                }
            }
        }
    }
    @IBAction func bottomButtonTapped(_ sender: Any) {
        if signUpMode
        {
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            signUpMode = false
        }
        else
        {
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
            signUpMode = true
        }
    }
    
    func presentAlertWhenError(alert: String) {
        let alertWindow = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertWindow.addAction(action)
        present(alertWindow, animated: true, completion: nil)
    }
    
}

