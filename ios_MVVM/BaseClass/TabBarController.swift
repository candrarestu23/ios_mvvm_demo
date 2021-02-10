//
//  BaseTabBar.swift
//  ios_MVVM
//
//  Created by Candra Restu on 04/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//
import UIKit

enum TabBarPosition: Int {
    case home
    case feed
    case cart
    case profile
}

class TabBarController: UITabBarController {
    private var homeViewController: HomeViewController!
    private var feedViewController: LogoutViewController!
    private var cartViewController: LogoutViewController!
    private var profileViewController: LogoutViewController!
    let searchBarWidth = UIScreen.main.bounds.width - 80
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: searchBarWidth, height: 60))
    
    private(set) var feedNav: UINavigationController?
    private(set) var cartNav: UINavigationController?
    private(set) var profileNav: UINavigationController?
    
    // MARK: - Initialize
    init() {
        homeViewController = HomeViewController()
        feedViewController = LogoutViewController()
        cartViewController = LogoutViewController()
        profileViewController = LogoutViewController()
        
        feedNav = UINavigationController(rootViewController: feedViewController)
        cartNav = UINavigationController(rootViewController: cartViewController)
        profileNav = UINavigationController(rootViewController: profileViewController)
        
        super.init(nibName: nil, bundle: nil)
        
        setViewControllers([homeViewController,
                            feedViewController!,
                            cartViewController!,
                            profileViewController!], animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewController.tabBarItem = configureTab(tabIndex: .home)
        feedViewController.tabBarItem = configureTab(tabIndex: .feed)
        cartViewController.tabBarItem = configureTab(tabIndex: .cart)
        profileViewController.tabBarItem = configureTab(tabIndex: .profile)
        
        // Remove top line
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        // Add tab bar shadow
        tabBar.shadowedView(tabBar, color: .black, offset: .zero, radius: 4, alpha: 0.3)
        tabBar.backgroundColor = UIColor.white
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        let rightBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // Set tab bar item based on index
    private func configureTab(tabIndex: TabBarPosition) -> UITabBarItem {
        var item = UITabBarItem()
        
        switch tabIndex {
        case .home:
            item = UITabBarItem(title: NSLocalizedString("HOME", comment: ""),
                                image: nil,
                                selectedImage: nil)
        case .feed:
            item = UITabBarItem(title: NSLocalizedString("FEED", comment: ""),
                                image: nil,
                                selectedImage: nil)
        case .cart:
            item = UITabBarItem(title: NSLocalizedString("CART", comment: ""),
                                image: nil,
                                selectedImage: nil)
        case .profile:
            item = UITabBarItem(title: NSLocalizedString("PROFILE", comment: ""),
                                image: nil,
                                selectedImage: nil)
        }
        
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)],
                                    for: .selected)
        return item
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title {
        case "PROFILE":
            let viewController = HistoryViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }
}

extension TabBarController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let viewController = SearchViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
