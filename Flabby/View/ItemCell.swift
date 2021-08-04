//
//  ItemCellTableViewCell.swift
//  Flabby
//
//  Created by mohamedSliem on 8/1/21.
//  Copyright © 2021 mohamedSliem. All rights reserved.
//

import UIKit
import Firebase

protocol deleteDelegate {
    func deleteAlert(_ content : String)
}
protocol checkBox
{
    func checkState(_ checked : Bool , _ content : String)
}
class ItemCell: UITableViewCell {

    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    var checked = false
    let db = Firestore.firestore()
    let username = (Auth.auth().currentUser?.displayName)!
    var delegate : deleteDelegate?
    var checkDelegate : checkBox?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func checkboxPressed(_ sender: UIButton)
    {
        checkDelegate?.checkState( checked , todoLabel.text!)
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton)
    {
        delegate?.deleteAlert(todoLabel.text!)
    }
}
