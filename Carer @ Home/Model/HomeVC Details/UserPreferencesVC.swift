//
//  UserPreferencesVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/01.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD

class UserPreferencesVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var defaultsSwitch: UISwitch!
    @IBOutlet weak var saveDefaultsYesNoLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var userName : String = ""
    var password : String = ""
    var emailAddress : String = ""
    
    let userDefaults = UserDefaults.standard
    let locale = Locale.current
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        hideKeyboardWhenTapped()
        if userDefaults.object(forKey: "firstName") != nil {
            firstNameTextField.text = userDefaults.object(forKey: "firstName") as? String
        }
        if userDefaults.object(forKey: "lastName") != nil {
            lastNameTextField.text = userDefaults.object(forKey: "lastName") as? String
        }
        emailTextField.text = userDefaults.object(forKey: "emailAddress") as? String
        if userDefaults.bool(forKey: "saveDetails") == true {
            defaultsSwitch.isOn = true
            saveDefaultsYesNoLabel.text = "Yes"
        } else {
            defaultsSwitch.isOn = false
            saveDefaultsYesNoLabel.text = "No"
        }
        print(locale.regionCode!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: IBActions

    @IBAction func saveDefaults(_ sender: UISwitch) {
        if defaultsSwitch.isOn == true {
            let alert = UIAlertController(title: "Save details", message: "Not recommended", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Save Log In details", style: .default, handler: { (alertAction) in
                self.saveDefaultsYesNoLabel.text = "Yes"
                self.userDefaults.set(true, forKey: "useMetric")
            })
            let alertAction2 = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction2) in
                self.saveDefaultsYesNoLabel.text = "No"
                self.defaultsSwitch.isOn = false
            })
            //let alertAction2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            alert.addAction(alertAction2)
            present(alert, animated: true, completion: nil)
        } else {
            saveDefaultsYesNoLabel.text = "No"
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if firstNameTextField.text == "" {
            let alert = UIAlertController(title: "User Name", message: "Please fill in your User Name", preferredStyle: .alert)
            let action = UIAlertAction(title: "fill in your Name", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            if defaultsSwitch.isOn {
                userDefaults.set(true, forKey: "saveDetails")
            } else {
                userDefaults.set(false, forKey: "saveDetails")
            }
            if locale.regionCode == "US" {
                userDefaults.set(false, forKey: "useMetric")
            } else {
                userDefaults.set(false, forKey: "useMetric")
            }
            userDefaults.set(firstNameTextField.text, forKey: "firstName")
            if lastNameTextField.text != "" {
                userDefaults.set(lastNameTextField.text, forKey: "lastName")
            }
            ProgressHUD.showSuccess("saved")
        }
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
    
}
