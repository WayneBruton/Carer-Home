//
//  RegisterViewController.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/11/28.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: IB Outlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordButton: UIButton!
    
    // MARK: Global Variables
    let userDefaults = UserDefaults.standard
    
    // MARK: ViewDid Load etc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        hideKeyboardWhenTapped()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IB Actions
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        checkDetails()
        }
    
    @IBAction func showPasswordButtonPressed(_ sender: UIButton) {
        if passwordTextField.text != ""  {
                if passwordTextField.isSecureTextEntry == true {
                    passwordTextField.isSecureTextEntry = false
                    let btnImage = UIImage(named: "Password-hide")
                    passwordButton.setImage(btnImage, for: UIControlState.normal)
                } else  {
                    passwordTextField.isSecureTextEntry = true
                    let btnImage = UIImage(named: "Password-show")
                    passwordButton.setImage(btnImage, for: UIControlState.normal)
            }
        }
    }
    @IBAction func cancelRegistrationButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Stop Registration", message: "Go back to Log in Screen", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "Return to Log in?", style: .default) { (alertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let alertAction2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        alert.addAction(alertAction2)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: End Editing
    
    func hideKeyboardWhenTapped() {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(RegisterViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    // MARK: Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomeScreen" {
//            let secondVC = segue.destination as! UINavigationController ====== Come Bachk to this
//            let hVC = secondVC.topViewController as! HomeVC
            
        }
    }
    
    // MARK: Check if fits email address requirements
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        //print(emailTest.evaluate(with: testStr))
        return emailTest.evaluate(with: testStr)
    }
    
    func checkDetails() {
        //Check - A field Blank - 1
        //Check - Invalid email address - 2
        //Check - Passwords do NOT match - 3
        var check : Int = 0
        if (emailTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "") {
            check = 1
        }
        if (isValidEmail(testStr: emailTextField.text!) == false) && (check != 1) {
            check = 2
        }
        if (check != 2) && (passwordTextField.text != confirmPasswordTextField.text ) {
            check = 3
        }
        switch check {
        case 1:
            let alert = UIAlertController(title: "Details", message: "All fields must be completed", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        case 2:
            let alert = UIAlertController(title: "EMAIL", message: "Your email address is not valid!!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Check Email", style: .default, handler: { (alertAction) in
                self.passwordTextField.text = ""
                self.confirmPasswordTextField.text = ""
                self.emailTextField.text = ""
            })
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            //print("Invalid email address")
        case 3:
            let alert = UIAlertController(title: "Password", message: "Confirmation Password does not agree", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Check Password", style: .destructive, handler: { (alertAction) in
                self.confirmPasswordTextField.text = ""
            })
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        default:
            ProgressHUD.showSuccess("Registering")
            userDefaults.set(emailTextField.text, forKey: "emailAddress")
            userDefaults.set(passwordTextField.text, forKey: "password")
            performSegue(withIdentifier: "goToHomeScreen", sender: self)
        }
    }
        
}




