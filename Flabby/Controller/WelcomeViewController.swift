//
//  ViewController.swift
//  Flabby
//
//  Created by mohamedSliem on 7/30/21.
//  Copyright © 2021 mohamedSliem. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    let text = "Flabby"
    var charIndex = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        titleLabel.text = ""
      // title animaton loop
        for letter in text
        {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats:false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
               charIndex += 1
        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
         self.performSegue(withIdentifier: "welcomeToSignup", sender: self)
        }
    }



}
