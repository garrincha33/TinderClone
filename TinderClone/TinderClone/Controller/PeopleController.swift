//
//  PeopleController.swift
//  TinderClone
//
//  Created by Richard Price on 10/03/2021.
//

import UIKit

class PeopleController: UITableViewController {
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PeopleTableControllerCustomCell.self, forCellReuseIdentifier: "cell")
        LoadUsers()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as? PeopleTableControllerCustomCell  else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.loadUser(user)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    private func LoadUsers() {
        Reference().databaseUsers.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                guard let user = User.transformUser(dict: dict) else {return}
                self.users.append(user)
            }
            self.tableView.reloadData()
        }
    }
}
