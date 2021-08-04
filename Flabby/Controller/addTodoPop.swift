//
//  addTodoPopUp.swift
//  Flabby
//
//  Created by mohamedSliem on 8/1/21.
//  Copyright © 2021 mohamedSliem. All rights reserved.
//

import UIKit
import Firebase

class addTodoPop: UIViewController {
 
    
    let username = Auth.auth().currentUser?.displayName
    let datePicker = UIDatePicker()
    let db = Firestore.firestore()
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var dateAndTimeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextField.addBottomLine()
        dateAndTimeTextField.addBottomLine()
        navigationController?.navigationBar.isHidden = true
        createDatePicker()

    }
    
    @IBAction func SaveButtonPressed(_ sender: UIButton)
    {
        if let content = contentTextField.text , let dateTime = dateAndTimeTextField.text , !content.isEmpty , !dateTime.isEmpty
        {
            db.collection(username!).document(content).setData([
                "content" : content ,
                "date&time": dateTime ,
                "checked" : false
            ])
            dismiss(animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title:"Sorry,Missing Data", message:"Do You want to Exit? ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Yes", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            self.present(alert,animated: true)
        }
    }
    
    func createDatePicker()
     {
           
             dateAndTimeTextField.textAlignment = .center
        
             let toolbar = UIToolbar()
             toolbar.sizeToFit()
          
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
             // assign the Button to the Bar
             toolbar.setItems([doneBtn], animated: true)
             
              //assign Toolbar to the DatePicker
             dateAndTimeTextField.inputAccessoryView = toolbar
        
              // assign textField Keyboard To DatePicker
              dateAndTimeTextField.inputView = datePicker
              datePicker.datePickerMode = .dateAndTime
     }
     @objc func donePressed()
     {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm a"
        dateAndTimeTextField.text = dateFormatter.string(from: datePicker.date)
        datePicker.endEditing(true)
     }
    

}
