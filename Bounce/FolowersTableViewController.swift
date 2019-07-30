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
    @IBOutlet weak var userTableView: UICollectionView!
    var followersViewModel: FollowersViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        followersViewModel = FollowersViewModel()
        followersViewModel.fetchFollowersDelegate = self
        
        userTableView.register(UINib(nibName: "FollowersCellCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "follower")
        
        
        followersViewModel.fetchFollowers(urlString: user.followersUrl)

    }
    

}

extension FolowersTableViewController:UICollectionViewDelegate, UICollectionViewDataSource{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return followersViewModel.getCellItemsCount()
    }
    
    //3
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let follower = followersViewModel.getCellItem(index: indexPath.row)
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "follower", for: indexPath) as! FollowersCellCollectionViewCell
            cell.updateCell(follower: follower)
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }

}

extension FolowersTableViewController: FetchFollowersDelegate {
    
    
    func fetchFollowersSucceeded(_ usersViewModel: FollowersViewModel) {
        userTableView.reloadData()
    }
    
    func fetchFollowersFailed(_ usersViewModel: FollowersViewModel, error: Error) {
        
    }
}
