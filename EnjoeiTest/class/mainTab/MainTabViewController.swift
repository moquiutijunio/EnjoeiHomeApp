//
//  MainTabViewController.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import Kingfisher
import Cartography

class MainTabViewController: UITabBarController {
    
    private lazy var homeViewController = HomeViewController()
    private lazy var searchViewController = UIViewController()
    private lazy var uploadViewController = UIViewController()
    private lazy var inboxViewController = UIViewController()
    private lazy var profileViewController = UIViewController()
    private lazy var profileController = UINavigationController(rootViewController: profileViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyLayout()
        addTabs()
        customProfileTabBarItem()
    }
    
    private func applyLayout() {
        view.backgroundColor = .white
        
        tabBar.tintColor = .gray2
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
    }
    
    private func addTabs() {
        let homeController = UINavigationController(rootViewController: homeViewController)
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
        
        profileViewController.title = NSLocalizedString("profile", comment: "")
        profileController.tabBarItem = UITabBarItem(title: nil,
                                                    image: UIImage(named: "ic_placeholder"),
                                                    selectedImage: UIImage(named: "ic_placeholder"))
        
        let controllers = [homeController, earchController, uploadController, inboxController, profileController]
        self.setViewControllers(controllers, animated: true)
    }
    
    private func customProfileTabBarItem() {
        
        UIImageView().kf.setImage(with: APIClient.currentUserAvatarURL) {[unowned self] (result) in
            
            switch result {
            case .success(let imageResult):
                let imageView = UIImageView()
                imageView.image = imageResult.image
                imageView.backgroundColor = .clear
                imageView.contentMode = .scaleAspectFit
                imageView.layer.cornerRadius =  12
                imageView.clipsToBounds = true
                
                let customView = UIView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
                customView.backgroundColor = .clear
                customView.layer.cornerRadius =  12

                customView.addSubview(imageView)
                constrain(customView, imageView, block: { (view, photo) in
                    photo.left == view.left + 2
                    photo.right == view.right - 2
                    photo.top == view.top + 2
                    photo.bottom == view.bottom - 2
                })
                
                self.profileController.tabBarItem.image = customView.toImage.withRenderingMode(.alwaysOriginal)

                //Change layout when tab bar did tap
                customView.layer.borderColor = UIColor.primaryColor.cgColor
                customView.layer.borderWidth = 1
                self.profileController.tabBarItem.selectedImage = customView.toImage.withRenderingMode(.alwaysOriginal)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
