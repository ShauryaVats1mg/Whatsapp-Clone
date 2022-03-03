//
//  SearchBarTableViewCell.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 01/03/22.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {

    @IBOutlet weak var searchBar: UISearchBar?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        searchBar?.backgroundImage = UIImage()
        
        self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
