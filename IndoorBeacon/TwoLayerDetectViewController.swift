//
//  TwoLayerDetectViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/3/6.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit
import Charts

class TwoLayerDetectViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var FirstBeaconLabel: UILabel!
    @IBOutlet weak var SecondBeaconLabel: UILabel!
    @IBOutlet weak var Principle: UIImageView!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    var count : Double = 0
    var SumRSSI = 0
    var months: [String] = []
    var Rssivalue:  [Double] = []
    var RSSIVALUE: Double = 0
    var ConvertToDouble: Double = 0
    
    var Rssivalue2:  [Double] = []
    var ConvertToDouble2: Double = 0
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //條件beacon power:-30db, ~1.5m
        let sortedBeacons = beacons.filter{ ($0.accuracy > 0.0)&&( 6 > $0.accuracy) }.sorted(){ $0.accuracy < $1.accuracy }
        
        print(sortedBeacons.count)
        /*
        if (sortedBeacons.count == 0){ // detect No beacon
            
            Principle.image = #imageLiteral(resourceName: "A∩B Original")
            FirstBeaconLabel.text = "1st.Beacon : "
            SecondBeaconLabel.text = "2nd.Beacon : "
            
            
        }else if (sortedBeacons.count == 1){ //detect one beacon
            
            let FirstBeacon = sortedBeacons[0] as CLBeacon
            
            if (FirstBeacon.major == 58791){
                
                print(FirstBeacon.major)
                FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                SecondBeaconLabel.text = "2nd.Beacon : "
                
                Principle.image = #imageLiteral(resourceName: "A-1")
                
            }else if (FirstBeacon.major == 44057){
                
                print(FirstBeacon.major)
                FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                SecondBeaconLabel.text = "2nd.Beacon : "
                
                Principle.image = #imageLiteral(resourceName: "B-1")
                
            }
            
        }*/
        
        if(sortedBeacons.count == 2){ //detect two beacon
            
            let FirstBeacon = sortedBeacons[0] as CLBeacon
            let SecondBeacon = sortedBeacons[1] as CLBeacon
         
            print(FirstBeacon.major)
            print(SecondBeacon.major)
         
            FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
            SecondBeaconLabel.text = "2nd.Beacon : \(SecondBeacon.major)"
            
            //顯示距離遠到近的iBeacon
            if (FirstBeacon.major == 58791 && SecondBeacon.major == 44057)||(FirstBeacon.major == 44057 && SecondBeacon.major == 58791){ //判斷為兩顆iBeacon
                
                Principle.image = #imageLiteral(resourceName: "A∩B-1")

                count = count + 1
                months += ["\(count.description)"]
                //SumRSSI = SumRSSI + (nearest.rssi)
                //let AverageRSSI = (Float(SumRSSI)/Float(count))
                print(months)
                
                //Int to Double 轉換
                //超級難Int to Double靠這行轉換
                ConvertToDouble = Double(FirstBeacon.rssi) + 0.0
                //把當前測得的RSSI值存到Array裡面e.x. Array[]=[0,1,2,3,...]
                Rssivalue += [ConvertToDouble]
                print(Rssivalue)
               
                //Savevalue(values1: [count], values2: Rssivalue)
                
                //2nd Beacon RSSI
                ConvertToDouble2 = Double(SecondBeacon.rssi) + 0.0
                Rssivalue2 += [ConvertToDouble2]
                print(Rssivalue2)
                
                //使座標軸好看些＆把Ｘ軸名稱值加上去
                lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:months )
                
                setChart(dataPoints: months, values: Rssivalue,  values2: Rssivalue2)
                //add.setChart(dataPoints: months, values: Rssivalue2)
            }
        }
    }
    /*
    func Savevalue(values1: [Double], values2: [Double]){
        
        for i in 0..<values1.count {
            
            let data = ChartDataEntry(x: Double(i), y: values2[i] )
            print(data)
            
        }
        
    }*/

    //加入圖表
    func setChart(dataPoints: [String], values: [Double], values2:[Double]) {
        
        var yVals1: [ChartDataEntry]  = []
        var yVals2: [ChartDataEntry]  = []
        
        for i in 0..<dataPoints.count {
            //let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            let dataEntryOne = ChartDataEntry(x: Double(i), y: values[i] )
            let dataEntryTwe = ChartDataEntry(x: Double(i), y: values2[i] )
            yVals1.append(dataEntryOne)
            yVals2.append(dataEntryTwe)
        }
        
        let lineChartDataSetyValue1 = LineChartDataSet(values: yVals1, label: "iBeacon1")
        let lineChartDataSetyValue2 = LineChartDataSet(values: yVals2, label: "iBeacon2")
        lineChartDataSetyValue1.highlightColor = UIColor.blue
        lineChartDataSetyValue2.highlightColor = UIColor.green
        //set1.setCircleColor(UIColor.red)
        
        //設定函數名稱顏色和連接線顏色ㄝsetColor
        lineChartDataSetyValue1.setColor(UIColor.blue)
        lineChartDataSetyValue2.setColor(UIColor.green)
        
        //設定函數線圈外匡顏色
        lineChartDataSetyValue1.setCircleColor(UIColor.blue)
        lineChartDataSetyValue2.setCircleColor(UIColor.green)
        
        //設定函數數值顏色valueTextColor
        lineChartDataSetyValue1.valueTextColor = UIColor.blue
        lineChartDataSetyValue2.valueTextColor = UIColor.green
        
        var dataSets = [IChartDataSet]()
        dataSets.append(lineChartDataSetyValue1)
        dataSets.append(lineChartDataSetyValue2)
        
        let lineChartD = LineChartData(dataSets:dataSets)

        lineChartView.data = lineChartD

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
