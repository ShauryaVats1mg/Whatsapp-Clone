//
//  MessageRecieveTableViewCell.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 10/03/22.
//

import UIKit

class MessageRecieveTableViewCell: UITableViewCell {

    @IBOutlet var message: UILabel!
    @IBOutlet var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
