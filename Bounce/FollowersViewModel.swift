//
//  FollowersViewModel.swift
//  Bounce
//
//  Created by Kunal on 30/07/19.
//  Copyright © 2019 Kunal. All rights reserved.
//


import Foundation

protocol FetchFollowersDelegate: class {
    func fetchFollowersSucceeded(_ usersViewModel: FollowersViewModel)
    func fetchFollowersFailed(_ usersViewModel: FollowersViewModel, error: Error)
}


class FollowersViewModel {
    
    var followers: [Follower] = []
    weak var fetchFollowersDelegate: FetchFollowersDelegate?
    
    
    func fetchFollowers(urlString:String) {
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // Make request
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                print("error")
                return
            }
            guard error == nil else {
                self.fetchFollowersDelegate?.fetchFollowersFailed(self, error: error!)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let followers = try decoder.decode([Follower].self, from: responseData)
                
                DispatchQueue.main.async {
                    self.followers = followers
                    self.fetchFollowersDelegate?.fetchFollowersSucceeded(self)
                }
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                self.fetchFollowersDelegate?.fetchFollowersFailed(self, error: error)
            }
        })
        task.resume()
    }
    
    
    func getCellItemsCount() -> Int {
        return followers.count
    }
    
    func getCellItem(index: Int) -> Follower {
        return followers[index]
    }
    
    
}
