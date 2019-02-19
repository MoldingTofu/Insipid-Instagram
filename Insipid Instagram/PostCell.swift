//
//  PostCell.swift
//  Insipid Instagram
//
//  Created by jeremy on 2/18/19.
//  Copyright © 2019 Jeremy Chang. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
