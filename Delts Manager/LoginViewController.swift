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
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self;
        passwordTextField.delegate = self;
    }
    
    @IBAction func loginPressed() {
        let email = emailTextField.text!;
        let password = passwordTextField.text!;
        
        // Try to authenticate
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (error == nil) {
                print("login yay!")
                self.loadUser();
            } else {
                self.displayError();
            }
        }
    }
    
    func loadUser() -> Void {
        let email = self.emailTextField.text!
        
        let endIndex = email.characters.index(of: "@")!
        let username = String(email.characters.prefix(upTo: endIndex))
        
        Constants.db.child("users").child(username).observeSingleEvent(of: .value, with: { (snapshot) in
            let dict = snapshot.value as? [String : AnyObject]
            
            let json = JSON(dict!)
            
            let firstName = json["first"].string
            let lastName = json["last"].string
            let year = json["pledgeyear"].int
            
            let user = User(firstName: firstName!, lastName: lastName!, year: year!, email: email)
            
            self.completeLoginFor(user)
        })
    }
    
    func completeLoginFor(_ user: User) -> Void {
        // Complete Login
        print(user.firstName + " " + user.lastName)
    }
    
    func displayError() -> Void {
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
