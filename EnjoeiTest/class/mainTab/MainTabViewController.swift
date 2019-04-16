//
//  MainTabViewController.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    private lazy var homeViewController = HomeViewController()
    private lazy var searchViewController = UIViewController()
    private lazy var uploadViewController = UIViewController()
    private lazy var inboxViewController = UIViewController()
    private lazy var profileViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyLayout()
        addTabs()
    }
    
    private func applyLayout() {
        view.backgroundColor = .white
        
        tabBar.tintColor = .gray2
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
    }
    
    private func addTabs() {
        let homeController = UINavigationController(rootViewController: homeViewController)
        homeViewController.title = NSLocalizedString("home", comment: "")
        homeController.tabBarItem = UITabBarItem(title: nil,
                                                 image: UIImage(named: "ic_home"),
                                                 selectedImage: UIImage(named: "ic_home_selected"))
        
        let earchController = UINavigationController(rootViewController: searchViewController)
        searchViewController.title = NSLocalizedString("search", comment: "")
        earchController.tabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage(named: "ic_search"),
                                                  selectedImage: UIImage(named: "ic_search_selected"))
        
        let uploadController = UINavigationController(rootViewController: uploadViewController)
        uploadViewController.title = NSLocalizedString("upload", comment: "")
        uploadController.tabBarItem = UITabBarItem(title: nil,
                                                   image: UIImage(named: "ic_upload"),
                                                   selectedImage: UIImage(named: "ic_upload_selected"))
        
        let inboxController = UINavigationController(rootViewController: inboxViewController)
        inboxViewController.title = NSLocalizedString("inbox", comment: "")
        inboxController.tabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage(named: "ic_inbox"),
                                                  selectedImage: UIImage(named: "ic_inbox_selected"))
        
        let profileController = UINavigationController(rootViewController: profileViewController)
        profileViewController.title = NSLocalizedString("profile", comment: "")
        profileController.tabBarItem = UITabBarItem(title: nil,
                                                    image: UIImage(named: "ic_avatar")?.withRenderingMode(.alwaysOriginal),
                                                    selectedImage: UIImage(named: "ic_avatar_selected")?.withRenderingMode(.alwaysOriginal))
        
        let controllers = [homeController, earchController, uploadController, inboxController, profileController]
        self.setViewControllers(controllers, animated: true)
    }
}
