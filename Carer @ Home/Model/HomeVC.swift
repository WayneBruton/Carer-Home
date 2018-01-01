//
//  HomeVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/11/29.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableViewHome: UITableView!

    let tableViewData = ["User Settings", "Contacts", "Patients", "Messages","Reports", "Feedback / Questions", "Latest News"]
    let tableViewImages = [ "preferences", "contacts","patients", "messages", "xray", "feedback", "news"]
    var navTitle = ""
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        tableViewHome.rowHeight = 60
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    override func viewWillAppear(_ animated: Bool) {
        adjustNavigationController()
    }
    
    // MARK: Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "user" {
            let userVC = segue.destination as! UserPreferencesVC
            userVC.title = navTitle
            navigationItem.title = ""
        }
        if segue.identifier == "contacts" {
            let userVC = segue.destination as! ContactsVC
            userVC.title = navTitle
            navigationItem.title = ""
        }
        if segue.identifier == "patients" {
            let userVC = segue.destination as! PatientsVC
            userVC.title = navTitle
            navigationItem.title = ""
        }
        if segue.identifier == "reports" {
            let userVC = segue.destination as! ReportsVC
            userVC.title = navTitle
            navigationItem.title = ""
        }
        if segue.identifier == "feedback" {
            let userVC = segue.destination as! FeedbackVC
            userVC.title = navTitle
            navigationItem.title = ""
        }
        if segue.identifier == "news" {
            let userVC = segue.destination as! NewsVC
            userVC.title = navTitle
            navigationItem.title = ""
        }
        if segue.identifier == "messages" {
            let userVC = segue.destination as! MessagesVC
            userVC.title = navTitle
            navigationItem.title = ""
        }
    }
    
    // MARK : Adjust Navigation Controller
    
    func adjustNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        if userDefaults.object(forKey: "firstName") != nil {
            self.navigationItem.title = "Hello \(String(describing: userDefaults.object(forKey: "firstName")!))"
        } else {
            self.navigationItem.title = "Hello"
        }
    }
    // MARK: TableView Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewHome.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath)
        let text = tableViewData[indexPath.row]
        cell.textLabel?.text = text
        let image = UIImage(named: tableViewImages[indexPath.row])
        cell.imageView?.image = image
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        navTitle = tableViewData[row]
        switch row {
        case 0:
            performSegue(withIdentifier: "user", sender: self)
        case 1:
            performSegue(withIdentifier: "contacts", sender: self)
        case 2:
            performSegue(withIdentifier: "patients", sender: self)
        case 3:
            performSegue(withIdentifier: "messages", sender: self)
        case 4:
            performSegue(withIdentifier: "reports", sender: self)
        case 5:
            performSegue(withIdentifier: "feedback", sender: self)
        case 6:
            performSegue(withIdentifier: "news", sender: self)
        default:
            print(tableViewData[row])
            
        }
        print(tableViewData[row])
    }
    
    // MARK: IB Actions
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Options", message: "", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "Sign Out", style: .default) { (alertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(signOutAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func messagesButtonPressed(_ sender: UIBarButtonItem) {
        navTitle = "Messages"
        performSegue(withIdentifier: "messages", sender: self)
    }
}
