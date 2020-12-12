//
//  NewTableViewCell.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/7/20.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var addToCart: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
