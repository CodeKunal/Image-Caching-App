//
//  FollowerViewController.swift
//  Bounce
//
//  Created by Kunal on 30/07/19.
//  Copyright © 2019 Kunal. All rights reserved.
//

import UIKit
import Kingfisher

class FollowerViewController: UIViewController {
    
    @IBOutlet weak var followerImageView: UIImageView!
    var follower: Follower!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = follower.name
        let url = URL(string: follower.avatarUrl)
        followerImageView.kf.setImage(with: url)
        followerImageView.backgroundColor = UIColor.blue
        animateImageView()
        // Do any additional setup after loading the view.
    }
    
    func animateImageView(){
        UIView.animate(withDuration: 2.0, animations: {() -> Void in
            self.followerImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 2.0, animations: {() -> Void in
                self.followerImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
