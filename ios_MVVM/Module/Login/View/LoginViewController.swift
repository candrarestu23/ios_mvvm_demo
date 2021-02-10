//
//  LoginViewController.swift
//  ios_MVVM
//
//  Created by Candra Restu on 04/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
class LoginViewController: UIViewController {

    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var googleSignInView: GIDSignInButton!
    @IBOutlet weak var facebookSignInView: FBLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLoginButton()
    }
    
    private func setStyle(){
        cardBackgroundView.dropShadow()
        cardBackgroundView.layer.cornerRadius = 4
        let string: String = String(describing: String.self)
        print(string)
    }
    
    private func setLoginButton(){
        GIDSignIn.sharedInstance()?.delegate = self
        
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            setNewController()
        }
        
        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
            request.start(completionHandler: {connection, result, error in
                self.setNewController()
            })
        }
        GIDSignIn.sharedInstance()?.presentingViewController = self
        facebookSignInView.permissions = ["public_profile", "email"]
    }
    
    private func setNewController(){
        let viewController = UINavigationController(rootViewController: TabBarController())
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if user != nil {
            setNewController()
        }
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
        request.start(completionHandler: {connection, result, error in
            self.setNewController()
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
}
