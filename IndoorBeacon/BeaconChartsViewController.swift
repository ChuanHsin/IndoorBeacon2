//
//  BeaconChartsViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/3/1.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit
import Charts

class BeaconChartsViewController: UIViewController, ESTBeaconManagerDelegate {

    @IBOutlet weak var RSSILabel: UILabel!
    @IBOutlet weak var DistLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    
    var sortedBeacons : [CLBeacon] = []
    var count : Double = 0
    var SumRSSI = 0
    var months: [String] = []
    var Rssivalue:  [Double] = []
    var RSSIVALUE: Double = 0
    var SumDist: Double = 0
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        beaconManager.requestWhenInUseAuthorization()
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon],in region: CLBeaconRegion) {

        sortedBeacons = beacons.filter(){ ($0.accuracy > 0.0)&&(1.5 > $0.accuracy) }.sorted(){ $0.accuracy < $1.accuracy }
        
        if let nearest = sortedBeacons.first {
            
            if nearest.major.int32Value == 58791 {
                let Distance = round((nearest.accuracy)*1000)/1000 //四捨五入取到小數第三位
                RSSILabel.text  = "RSSI : \(nearest.rssi)"
                DistLabel.text  = "Dist : \(Distance) m"
                
                count = count + 1
                months += ["\(count.description)"]
                //SumRSSI = SumRSSI + (nearest.rssi)
                //let AverageRSSI = (Float(SumRSSI)/Float(count))
                
                print(months)
                //Int to Double 轉換
                SumDist = Double(nearest.rssi) + 0.0
                
                Rssivalue += [SumDist]
                
                print(Rssivalue)
                //加入限定線
                //let ll = ChartLimitLine(limit: Double(AverageRSSI), label: "Target")
                //lineChartView.rightAxis.addLimitLine(ll)
                
                //使座標軸好看些＆把Ｘ軸名稱值加上去
                lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:months )
                
                setChart(dataPoints: months, values: Rssivalue )
                
            }
        }
    }
    //加入圖表
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            //let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i] )
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        //X軸名稱加置底部
        lineChartView.xAxis.labelPosition = .bottom
        //保護設定Ｘ軸穩定圖形
        lineChartView.xAxis.granularity = 1
        lineChartView.xAxis.granularityEnabled = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beaconManager.delegate = self
        // Do any additional setup after loading the view.
        self.beaconManager.requestAlwaysAuthorization()
        
        //setChart(dataPoints: months, values: Rssivalue[]  )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeacons(in: self.beaconRegion)
        //print("will")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeacons(in: self.beaconRegion)
    }

}
