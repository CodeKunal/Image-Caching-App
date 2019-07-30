//
//  UsersTableViewController.swift
//  Bounce
//
//  Created by Kunal on 30/07/19.
//  Copyright © 2019 Kunal. All rights reserved.
//

import UIKit

class UsersTableViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    var usersViewModel: UsersViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        usersViewModel = UsersViewModel()
        usersViewModel.fetchUsersDelegate = self
        
        userTableView.register(UINib.init(nibName: "UserTableViewCell", bundle: .main), forCellReuseIdentifier: "UserTableViewCell")

        usersViewModel.fetchUsers()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func redirectToUserDetailsScreen(user: User) {
        let folowersTableViewController = FolowersTableViewController()
        folowersTableViewController.user = user
        navigationController?.pushViewController(folowersTableViewController, animated: true)
    }


}
extension UsersTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel.getCellItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellUser = usersViewModel.getCellItem(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
//        cell.userSummaryCellDelegate = self
        cell.updateCell(user: cellUser)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellUser = usersViewModel.getCellItem(index: indexPath.row)
        redirectToUserDetailsScreen(user: cellUser)
    }
}

extension UsersTableViewController: FetchUsersDelegate {
    
    
    func fetchUsersSucceeded(_ usersViewModel: UsersViewModel) {
        userTableView.reloadData()
    }
    
    func fetchUsersFailed(_ usersViewModel: UsersViewModel, error: Error) {

    }
}
