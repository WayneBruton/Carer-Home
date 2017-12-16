//
//  TemperatureVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/06.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD
import GMStepper

class TemperatureVC: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempChangeStepper: GMStepper!
    
    var temp = 37.0
    var vcTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temperatureLabel.text = "37 ℃"
        tempChangeStepper.value = 37.0
        vcTitle = self.title!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IB Actions
    

    @IBAction func tempChangeStepper(_ sender: GMStepper) {
        temp = tempChangeStepper.value
        temp = (round(temp * 10))/10
        tempChangeStepper.value = temp
        temperatureLabel.text = "\(temp) ℃"
        if temp > 37.2 {
            temperatureLabel.textColor = UIColor.red
        } else if temp < 36.1 {
            temperatureLabel.textColor = UIColor.blue
        } else {
            temperatureLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save", message: "Save Temperature Readings", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (saveAction) in
            ProgressHUD.showSuccess("Saved")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func chartBarButtonPressed(_ sender: UIBarButtonItem) {
        let chartAlert = UIAlertController(title: "Charts", message: "Show visual representation", preferredStyle: .actionSheet)
        let barAction = UIAlertAction(title: "Bar Chart", style: .default) { (barAction) in
            //Open VC goes here
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BarChart") as! BarChartVC
            
            vc.lastTempReading = self.temp
            vc.title = self.vcTitle
            //self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            self.present(vc, animated: true, completion: nil)
        }
        let lineAction = UIAlertAction(title: "Line Chart", style: .default) { (lineAction) in
            //Vc Goes Here
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LineChart") as! LineChartVC
            
            vc.lastTempReading = self.temp
            vc.title = self.vcTitle
            //self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            self.present(vc, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        chartAlert.addAction(barAction)
        chartAlert.addAction(lineAction)
        chartAlert.addAction(cancelAction)
        present(chartAlert, animated: true, completion: nil)
    }
    
    
    
}
