//
//  patientDetailVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/04.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD


class patientDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var testsData: UITableView!
    
    var tests = ["Patient Details","Reports", "Blood Glucose", "Blood Pressure", "Fall Risk Scale", "Fluid Intake", "Functional Scale (Fim)", "Mental State", "Pain Scale",  "Palliative Care - ECOG Scale", "Pulse",  "Respiratory Rate","Temperature",   "Urine Albumin", "Urine Glucose", "Wound Status"]
    
    var testsImages = ["Patientdetails","Patientreports", "BloodGlucose", "BloodPressure", "FallRisk", "FluidIntake",  "FunctionalScale",  "MentalState",  "PainScale", "Palliative", "Pulse", "RespiratoryRate", "Temperature", "UrineAlbumin", "UrineGlucose", "WoundStatus"]
    var navTitle = ""
    var vcTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testsData.delegate = self
        testsData.dataSource = self
        vcTitle = self.title!
        testsData.rowHeight = 60
        print(vcTitle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        delegate?.sendNavTitleToFallRisk(navTitle: vcTitle)
//        //self.title = vcTitle
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        delegate?.sendNavTitleToFallRisk(navTitle: vcTitle)
//    }
    
    /*
    "Patient Details" 0
    "Blood Glucose" 2
    "Blood Pressure" - Done
    "Fall Risk Scale" - Done
    "Fluid Intake" - Done
    "Funcional Scale (Fim)" 6
    "Mental State" 7
    "Pain Scale" 8 - DONE
    "Palliative Care - ECOG Scale" 9
    "Pulse" - Done
    "Respiratory Rate" 11
    "Temperature" 12 Done
    "Urine Albumin" 13
    "Urine Glucose" 14
    "Wound Status" 15
    */
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    // MARK: Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Blood Pressure" {
            let VC = segue.destination as! BloodPressureVC
            VC.title = "\(navTitle) - \(vcTitle)"
            navigationItem.title = ""
        }
        if segue.identifier == "Fluid Intake" {
            let VC = segue.destination as! FluidIntakeVC
            VC.title = "\(navTitle) - \(vcTitle)"
            navigationItem.title = ""
        }
        if segue.identifier == "Pulse" {
            let VC = segue.destination as! PulseVC
            VC.title = "\(navTitle) - \(vcTitle)"
            navigationItem.title = ""
        }
        if segue.identifier == "temperature" {
            let VC = segue.destination as! TemperatureVC
            VC.title = "\(navTitle) - \(vcTitle)"
            navigationItem.title = ""
            
        }
        if segue.identifier == "Pain" {
            let VC = segue.destination as! PainVC
            VC.title = "\(navTitle) - \(vcTitle)"
            navigationItem.title = ""
        }
        if segue.identifier == "BloodSugar" {
            let VC = segue.destination as! BloodSugarVC
            VC.title = "\(navTitle) - \(vcTitle)"
            navigationItem.title = ""
        }
        if segue.identifier == "Fall Risk" {
            let VC = segue.destination as! PageViewController
            VC.title = "\(navTitle) - \(vcTitle)"
            navigationItem.title = ""
        }
        if segue.identifier == "Respiratory Rate" {
            let VC = segue.destination as! RespiratoryRateVC
            VC.title = "\(navTitle) - \(vcTitle)"
            navigationItem.title = ""
        }
        if segue.identifier == "FallRisk" {
            let VC = segue.destination as! FallRiskVC
            VC.title = "\(navTitle) - \(vcTitle)"
            navigationItem.title = ""
        }
    }
    
    // MARK: Table View Setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = tests.count
        //print(count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = testsData.dequeueReusableCell(withIdentifier: "patientTests", for: indexPath)
        let text = tests[indexPath.row]
        let image = UIImage(named: testsImages[indexPath.row])
        cell.textLabel?.text = text
        cell.imageView?.image = image
        
        return cell
    }
    //This will ultimately be perform segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        navTitle = tests[row]
        switch row {
        case 0:
            ProgressHUD.showSuccess("Open: \(vcTitle):  \(navTitle)")
        case 1:
            ProgressHUD.showSuccess("Open: \(vcTitle):  \(navTitle)")
        case 2:
            performSegue(withIdentifier: "BloodSugar", sender: self)
        case 3:
            performSegue(withIdentifier: "Blood Pressure", sender: self)
        case 4:
            //performSegue(withIdentifier: "Fall Risk", sender: self)
            performSegue(withIdentifier: "FallRisk", sender: self)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
//
//            //vc.lastTempReading = self.temp
//            vc.title = self.vcTitle
//            //self.navigationController?.pushViewController(vc, animated: true)
//            self.present(vc, animated: true, completion: nil)
        case 5:
            performSegue(withIdentifier: "Fluid Intake", sender: self)
        case 6:
            ProgressHUD.showSuccess("Open: \(vcTitle):  \(navTitle)")
        case 7:
            ProgressHUD.showSuccess("Open: \(vcTitle):  \(navTitle)")
        case 8:
            performSegue(withIdentifier: "Pain", sender: self)
        case 9:
            ProgressHUD.showSuccess("Open: \(vcTitle):  \(navTitle)")
        case 10:
            performSegue(withIdentifier: "Pulse", sender: self)
        case 11:
            performSegue(withIdentifier: "Respiratory Rate", sender: self)
        case 12:
            performSegue(withIdentifier: "temperature", sender: self)
        case 13:
            ProgressHUD.showSuccess("Open: \(vcTitle):  \(navTitle)")
        case 14:
            ProgressHUD.showSuccess("Open: \(vcTitle):  \(navTitle)")
        case 15:
            ProgressHUD.showSuccess("Open: \(vcTitle):  \(navTitle)")
        default:
            ProgressHUD.showSuccess("Open: \(vcTitle)")
        }
    }
}
