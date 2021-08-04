//
//  MainViewController.swift
//  Flabby
//
//  Created by mohamedSliem on 8/1/21.
//  Copyright © 2021 mohamedSliem. All rights reserved.
//

import UIKit
import Firebase
class MainViewController: UIViewController , deleteDelegate,checkBox {
  
    


    @IBOutlet weak var todoListTable: UITableView!
    var items : [Item] = []
    let db = Firestore.firestore()
    let username = Auth.auth().currentUser?.displayName
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let navBar = navigationController?.navigationBar
        navBar?.isHidden = false
        self.title = username
        
        todoListTable.backgroundView = UIImageView(image: UIImage(named: "background 2"))
        // delegate
        todoListTable.dataSource = self
        todoListTable.delegate = self
       
        todoListTable.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        getUserData()
        
    }
    
    func getUserData()
    {
        db.collection(username!).addSnapshotListener { (querySanpshot, error) in
            self.items = []
            if let e = error
            {
                print(e.localizedDescription)
            }
            else
            {
                if let snapShotDoc = querySanpshot?.documents
                {
                  for doc in snapShotDoc
                  {
                    let data = doc.data()
                    
                   
                    if let content = data["content"] as? String , let dateAndTime = data["date&time"] as? String ,let checked = data["checked"]as? Bool,!dateAndTime.isEmpty
                    {
                        let newItem = Item(content: content,Date: dateAndTime,checked: checked)
                        self.items.append(newItem)
                        
                    }
             
                    
                  }
                }
                DispatchQueue.main.async
                {
                   self.todoListTable.reloadData()
                }
            }
        }
    }
 
    //BackButton Leads to logOut
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem)
    {
        do
        {
          try Auth.auth().signOut()
          navigationController?.popViewController(animated: true)
        }
        catch let signOutError as NSError
          {
           print(signOutError)
          }
       
    }
    @IBAction func addNoteButtonPressed(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier:"addNote", sender: self)
    
     }
    

   // delete Delegate Function
    func deleteAlert(_ content: String) {
    print("delegate triggerd")
       let alert = UIAlertController(title: "Sorry", message: "You want to delete this todo", preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (deleteAction) in
        self.db.collection(self.username!).document(content).delete(){error
                     in
                     if let e = error
                     {
                         print(e.localizedDescription)
                     }
                 }
       }))
       alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
       self.present(alert,animated: true)
    }
    
     // CHECK Box delegate
    // Updating the checkbox State in Firebase
    
    func checkState( _ checked : Bool , _ content : String)
    {
        db.collection(username!).document(content).updateData([
            "checked": !checked
        ])
    }
 
  }



extension MainViewController : UITableViewDataSource ,UITableViewDelegate 
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
 
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:"ReusableCell", for: indexPath) as! ItemCell
        cell.todoLabel.text = item.content
        cell.dateAndTimeLabel.text = item.Date
        cell.checked = item.checked
        cell.backgroundColor = UIColor.clear
        
        cell.delegate = self   //Alert delete Delegate
        cell.checkDelegate = self //checBox State delegate
     
        
        //the method of changing the background of the cell due to checkBox state 
        if cell.checked
          {
            cell.checkboxButton.setImage(UIImage(named: "download"), for: .normal)
            cell.background.backgroundColor = UIColor(red: 140/255.0, green: 94/255.0, blue: 190/255.0, alpha:0.7)
          }
          else
          {
            cell.checkboxButton.setImage(UIImage(named: "download-1"), for: .normal)
            cell.background.backgroundColor = UIColor.clear
           
          }
        
        return cell
    }

}

