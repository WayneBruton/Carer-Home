//
//  InitialViewController.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/11/28.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD

class InitialViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var emailAddress : String!
    var password : String!
    var saveDetails : Bool!
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
        passwordTextField.delegate = self
        hideKeyboardWhenTapped()
        checkUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IB Actions
    
    //Go to Register VC
    @IBAction func registerButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "register", sender: self)
    }
    
    @IBAction func logInButonPressed(_ sender: UIButton) {
        checkDetails()
    }

    // MARK: End Editing
    
    func hideKeyboardWhenTapped() {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(InitialViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    // MARK: Check valid email address
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        //print(emailTest.evaluate(with: testStr))
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: Check all fields input correctly before Segue
    
    func checkDetails() {
        //Check - A field Blank - 1
        //Check - Invalid email address - 2
        
        var check : Int = 0
        if (userTextField.text == "" || passwordTextField.text == "" ) {
            check = 1
        }
        if (isValidEmail(testStr: userTextField.text!) == false) && (check != 1) {
            check = 2
        }
        
        switch check {
        case 1:
            let alert = UIAlertController(title: "Details", message: "All fields must be completed", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            //print("All Fields must be filled In!!")
        case 2:
            let alert = UIAlertController(title: "EMAIL", message: "Your email address is not valid!!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Check Email", style: .default, handler: { (alertAction) in
                self.userTextField.text = ""
                self.passwordTextField.text = ""
            })
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            //print("Invalid email address")
        default:
            performSegue(withIdentifier: "goToHomeScreen", sender: self)
        }
    }
    
    // MARK : Check User Defaults
    func checkUserDefaults() {
        if userDefaults.object(forKey: "emailAddress") != nil {
            emailAddress = userDefaults.object(forKey: "emailAddress") as! String
            print(emailAddress)
        } else {
            emailAddress = ""
        }
        if userDefaults.object(forKey: "password") != nil {
           password = userDefaults.object(forKey: "password") as! String
            print(password)
        } else {
            password = ""
        }
        if (userDefaults.bool(forKey: "saveDetails") == true)  {
           userTextField.text = emailAddress
            passwordTextField.text = password
        } else {
            print("Nothing Saved")
        }
    }
}


