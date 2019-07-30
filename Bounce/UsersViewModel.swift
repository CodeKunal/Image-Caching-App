//
//  UsersViewModel.swift
//  Bounce
//
//  Created by Kunal on 30/07/19.
//  Copyright © 2019 Kunal. All rights reserved.
//

import Foundation

protocol FetchUsersDelegate: class {
    
    func fetchUsersSucceeded(_ usersViewModel: UsersViewModel)
    func fetchUsersFailed(_ usersViewModel: UsersViewModel, error: Error)
}


class UsersViewModel {
    
    var users: [User] = []
    weak var fetchUsersDelegate: FetchUsersDelegate?
    

    func fetchUsers() {
        let endpoint = User.endpointForUsers()
        guard let url = URL(string: endpoint) else {
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
                self.fetchUsersDelegate?.fetchUsersFailed(self, error: error!)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let users = try decoder.decode([User].self, from: responseData)
                self.users = users
                DispatchQueue.main.async {
                    self.fetchUsersDelegate?.fetchUsersSucceeded(self)
                }
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                self.fetchUsersDelegate?.fetchUsersFailed(self, error: error)
            }
        })
        task.resume()
    }
    
    
    func getCellItemsCount() -> Int {
        return users.count
    }
    
    func getCellItem(index: Int) -> User {
        return users[index]
    }
    
    
}
