//
//  LoginViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/12/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import Material

class LoginViewController: UIViewController {

    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // Light Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self;
        passwordTextField.delegate = self;
        
        self.loginButton.layer.cornerRadius = 5.0
    }
    
    
    // Try to login!
    @IBAction func loginPressed() {
        self.loginButton.isEnabled = false
        
        let email = emailTextField.text!;
        let password = passwordTextField.text!;
        
        Session.signIn(withEmail: email, password: password) { (error) in
            if error == nil {
                self.completeLogin()
            } else {
                self.displayError()
                self.loginButton.isEnabled = true
            }
        }
    }
    
    func completeLogin() {
        print(Session.session.owner?.fullName ?? "")
        
//        let controller = TabBarController(viewControllers: [OverviewViewController(), DutiesViewController(), PuntsViewController(), SettingsViewController()])
        
        
//        self.navigationController?.pushViewController(controller, animated: true)
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: Constants.Identifiers.Controllers.TabBarController) as! TabBarController
        
        let navController = TodayNavigationController(rootViewController: OverviewViewController())
        controller.viewControllers?.insert(navController, at: 0)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func displayError() -> Void {
        Errors.presentError(.SignInFailedError, onController: self, withMessage: "Please try again.")
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.emailTextField) {
            textField.resignFirstResponder();
            passwordTextField.becomeFirstResponder()
        }
        
        if (textField == self.passwordTextField) {
            textField.resignFirstResponder();
            loginPressed();
        }
        
        return true;
    }
    
    // MARK: Keyboard Dismiss
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(textField: emailTextField!)
        resignIfFirstResponder(textField: passwordTextField!)
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
}

class TodayNavigationController: NavigationController {
    open override func prepare() {
        super.prepare()
        guard let v = navigationBar as? NavigationBar else {
            return
        }
        
        v.depthPreset = .none
        v.dividerColor = Color.grey.lighten3
        v.backgroundColor = UIColor.flatPurpleDark
        
        self.tabBarItem.image = #imageLiteral(resourceName: "today_icon").tint(with: .flatGray)
        self.tabBarItem.selectedImage = #imageLiteral(resourceName: "today_icon").tint(with: .flatPurple)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        self.tabBarItem.image = Icon.bell
        self.tabBarItem.selectedImage = Icon.add
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
