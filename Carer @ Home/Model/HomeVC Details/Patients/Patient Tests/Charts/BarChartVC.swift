//
//  BarChartVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/12.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD
import Charts


class BarChartVC: UIViewController {
    
    // MARK: IB Outlets

    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var bloodGlucoseSegmentControl: UISegmentedControl!
    @IBOutlet weak var headerLabel: UILabel!
    
    // MARK: Variables & Constants
    
    var lastTempReading = Double()
    var myArray = [Double]()
    var myDateArray = [String]()
    var today = Date()
    let calendar = Calendar.current
    let dayLength : TimeInterval = 60.0 * 60.0 * 24 //let minute : TimeInterval = 60.0 //let hour : TimeInterval = 60.0 * minute
    
    // MARK: ViewDidLoad etc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navigationItem.title!
        dateToday()
        headerLabel.text = title
        createDataSets()
        setChart(dataPoints: myDateArray, values: myArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: IB Actions
    
    @IBAction func exitButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButonPressed(_ sender: UIBarButtonItem) {
        ProgressHUD.showSuccess("Coming Soon")
    }
    
    // MARK: Functions
    
    func dateToday() {
        let year = calendar.component(.year, from: today)
        let month = calendar.component(.month, from: today)
        let day = calendar.component(.day, from: today)
        myDateArray.append("\(day)-\(month)-\(year)")
    }
    
    func createDataSets() {
        myArray = [37.0,36.4,36.0,37.0,38.5,37.5]
        myArray.append(lastTempReading)
        for _ in 0..<6  {
            today = today - dayLength
            let year = calendar.component(.year, from: today)
            let month = calendar.component(.month, from: today)
            let day = calendar.component(.day, from: today)
            myDateArray.append("\(day)-\(month)-\(year)")
        }
        myDateArray.reverse()
    }
    
    func setChart(dataPoints : [String], values : [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: title)
        
        
        chartDataSet.colors = [UIColor.blue]

        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints) // X Axis Labels
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelRotationAngle = 90
        barChart.xAxis.drawGridLinesEnabled = false
        //barChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        let llmax = ChartLimitLine(limit: 37.1, label: "")
        let llmin = ChartLimitLine(limit: 36.2, label: "")
        barChart.rightAxis.addLimitLine(llmax)
        barChart.rightAxis.addLimitLine(llmin)
        
        barChart.chartDescription?.text = ""
        barChart.data = chartData
        
        //barChart.saveToPath(path: String, format: ChartViewBase.ImageFormat, compressionQuality: Double)

    }
}
