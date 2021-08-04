//
//  LoginViewController.swift
//  Flabby
//
//  Created by mohamedSliem on 7/31/21.
//  Copyright © 2021 mohamedSliem. All rights reserved.
//

import UIKit
import Firebase
class loginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        emailTextField.addBottomLine()
        passwordTextField.addBottomLine()
       
    }
    @IBAction func signinButtonPressed(_ sender: UIButton)
    {
        if let email = emailTextField.text , let password = passwordTextField.text,!email.isEmpty,!password.isEmpty
        {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
               
                if let e = error
                {
                    let alert = UIAlertController(title: "Sorry", message: e.localizedDescription, preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                      self.present(alert,animated: true)
                }
                else
                {
                    self.performSegue(withIdentifier: "signinToMain", sender: self)
                }
            }
        }
        else
        {
            let alert = UIAlertController(title: "Sorry", message: "You must fill all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert,animated: true)
        }
    }
    

    @IBAction func signupButtonPressed(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
        
    }

}
