//
//  WelcomeViewController.swift
//  Check-ins
//
//  Created by Dimitar on 27.1.21.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onFacebook(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login error", message: error.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                } else {
                    if Auth.auth().currentUser != nil {
                        self.performSegue(withIdentifier: "Home", sender: nil)
                    }
                }
            }
        }

    }
    @IBAction func onLogin(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
   
    
    @IBAction func onCreateAccount(_ sender: Any) {
        performSegue(withIdentifier: "createAccount", sender: nil)
    }
}
