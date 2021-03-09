//
//  MessagesController.swift
//  TinderClone
//
//  Created by Richard Price on 09/03/2021.
//

import UIKit
import Firebase
import FirebaseAuth

class MessagesController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.backgroundColor = .cyan
        navigationItem.title = Auth.auth().currentUser?.uid
        
    }
    
}
