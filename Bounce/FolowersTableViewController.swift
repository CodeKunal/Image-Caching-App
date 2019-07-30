//
//  FolowersTableViewController.swift
//  Bounce
//
//  Created by Kunal on 30/07/19.
//  Copyright © 2019 Kunal. All rights reserved.
//

import UIKit

class FolowersTableViewController: UIViewController {
    var user: User!
    
    @IBOutlet weak var followersCollectionView: UICollectionView!
    
//    @IBOutlet weak var followerCollectionView: UICollectionView!
    var followersViewModel: FollowersViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        followersViewModel = FollowersViewModel()
        followersViewModel.fetchFollowersDelegate = self
        
        followersCollectionView.register(UINib(nibName: "FollowersCellCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "follower")
        
        
        followersViewModel.fetchFollowers(urlString: user.followersUrl)
        
    }
    
    
}

extension FolowersTableViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return followersViewModel.getCellItemsCount()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let follower = followersViewModel.getCellItem(index: indexPath.row)
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "follower", for: indexPath) as! FollowersCellCollectionViewCell
        cell.updateCell(follower: follower)
        return cell
    }
    
    func redirect(follower: Follower) {
        let followerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "followerVC") as! FollowerViewController
        followerViewController.follower = follower
        navigationController?.pushViewController(followerViewController, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellFollower = followersViewModel.getCellItem(index: indexPath.row)
        redirect(follower: cellFollower)
    }
    
}

extension FolowersTableViewController: FetchFollowersDelegate {
    
    
    func fetchFollowersSucceeded(_ usersViewModel: FollowersViewModel) {
        followersCollectionView.reloadData()
    }
    
    func fetchFollowersFailed(_ usersViewModel: FollowersViewModel, error: Error) {
        
    }
}
