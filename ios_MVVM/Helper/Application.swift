//
//  Application.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 04/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FBSDKCoreKit

final class Application {
    static let shared = Application()


    @discardableResult
    func configureMainInterface(window: inout UIWindow) -> UIViewController {
        UINavigationBar.appearance().tintColor = UIColor.white

        if let token = AccessToken.current, !token.isExpired || GIDSignIn.sharedInstance()?.currentUser != nil {
            let rootNav: UINavigationController = UINavigationController(rootViewController: LoginViewController())
            return rootNav
            
        } else {
            let rootNav: UINavigationController = UINavigationController(rootViewController: LoginViewController())
            rootNav.navigationBar.isHidden = true
            window.rootViewController = rootNav
            return rootNav
            
        }
    }
}
