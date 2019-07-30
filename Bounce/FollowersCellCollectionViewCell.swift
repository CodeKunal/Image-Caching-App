//
//  FollowersCellCollectionViewCell.swift
//  Bounce
//
//  Created by Kunal on 30/07/19.
//  Copyright © 2019 Kunal. All rights reserved.
//

import UIKit
import Kingfisher

class FollowersCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(follower:Follower){
        let url = URL(string: follower.avatarUrl)
        imageView.kf.setImage(with: url)
        name.text = follower.name
    }


}
