//
//  UserTableViewCell.swift
//  Bounce
//
//  Created by Kunal on 30/07/19.
//  Copyright © 2019 Kunal. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(user:User){
        let url = URL(string: user.avatarUrl)
        userImageView.kf.setImage(with: url)
        userName.text = user.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

