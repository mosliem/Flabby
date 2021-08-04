//
//  SignupViewController.swift
//  Flabby
//
//  Created by mohamedSliem on 7/30/21.
//  Copyright © 2021 mohamedSliem. All rights reserved.
//

import UIKit
import Firebase
class SignupViewController: UIViewController {
   
    let db = Firestore.firestore()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        //textField bottom line
        usernameTextField.addBottomLine()
        emailTextField.addBottomLine()
        passwordTextField.addBottomLine()
    
    }
    

    @IBAction func signupButtonPressed(_ sender: UIButton)
    {
        if let username = usernameTextField.text ,let email = emailTextField.text , let password = passwordTextField.text,!username.isEmpty,!password.isEmpty,!email.isEmpty
          {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult,error) in
                if let e = error
                {
                    let alert = UIAlertController(title: "Sorry", message: e.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                      self.present(alert,animated: true)
                }
                else
                {
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = username
                    changeRequest?.commitChanges { error in
                      if let e = error
                      {
                        print(e.localizedDescription)
                      }
                      else
                      {
                        self.db.collection(username).addDocument(data:
                        [
                            "root" : "root"
                        ])
                        self.performSegue(withIdentifier: "signupToMain", sender: self)
                      }
                    }
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

    @IBAction func SigninButtonPressed(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "signupToSignin", sender: self)
    }
}


extension UITextField
{
    func addBottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height-1, width:self.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.systemIndigo.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
  
}

extension UILabel
{
    func addBottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height-1, width:self.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.systemIndigo.cgColor
        self.layer.addSublayer(bottomLine)
    }
  
}
