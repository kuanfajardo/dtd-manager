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
        let email = emailTextField.text!;
        let password = passwordTextField.text!;
        
        Session.signIn(withEmail: email, password: password) { (error) in
            if error == nil {
                self.completeLogin()
            } else {
                self.displayError()
            }
        }
    }
    
    func completeLogin() {
        print(Session.session.owner?.fullName ?? "")
        let controller = self.storyboard?.instantiateViewController(withIdentifier: Constants.Identifiers.Controllers.TabBarController)
        self.navigationController?.pushViewController(controller!, animated: true)
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
