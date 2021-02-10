//
//  LogoutViewController.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class LogoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onClickLogout(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        let viewController = UINavigationController(rootViewController: LoginViewController())
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
