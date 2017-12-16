//
//  PatientsVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/01.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit

class PatientsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var patientsTableView: UITableView!
    
    let patientData = ["June Druker", "Bruce Lee", "Jacob Zuma", "Shane Plunket "]
    
    var navTitle = ""
    var vcTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientsTableView.delegate = self
        patientsTableView.dataSource = self
        vcTitle = self.title!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = vcTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Table View Set-up
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = patientsTableView.dequeueReusableCell(withIdentifier: "patientTableViewCell", for: indexPath)
        let text = patientData[indexPath.row]
        cell.textLabel?.text = text
        cell.imageView?.image = UIImage(named: "Patients1")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        navTitle = patientData[row]
        performSegue(withIdentifier: "patientDetail", sender: self)
        
    }
    
    // MARK: IBOutlets
    
    @IBAction func addPationtButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Patient", message: "Add New Patient", preferredStyle: .actionSheet)
        let addAction = UIAlertAction(title: "Add Patient", style: .default) { (addAction) in
            print("Add Client Here")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "patientDetail" {
            let VC = segue.destination as! patientDetailVC
            VC.title = navTitle
            navigationItem.title = ""
        }
    }
    
}
