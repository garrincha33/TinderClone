//
//  MainTabBarController.swift
//  TinderClone
//
//  Created by Richard Price on 12/02/2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBarControllers()
    }

    private func setupNavController(with rootViewController: UIViewController, title: String, image: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = UIImage(named: image)
        navController.tabBarItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    private func setupTabBarControllers() {
        viewControllers = [
            setupNavController(with: MessagesController(), title: "Messages", image: "icon_messages"),
            setupNavController(with: UIViewController(), title: "Users", image: "icon_users"),
            setupNavController(with: MeController(), title: "Me", image: "icon_profile")
        ]
        tabBar.tintColor = .purple
        guard let items = tabBar.items else {return}
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }
        guard let titleItems = tabBar.items else {return}
        for items in titleItems {
            items.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        }
    }
}
