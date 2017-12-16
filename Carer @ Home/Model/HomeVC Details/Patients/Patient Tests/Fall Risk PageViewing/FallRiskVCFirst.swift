//
//  FallRiskVCFirst.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/16.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit

class FallRiskVCFirst: UIViewController {
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.topItem?.title = "Hello"
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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
