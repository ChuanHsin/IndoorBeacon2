//
//  ExpTwoBeaconViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/3/7.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit

class ExpTwoBeaconViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var FirstBeaconLabel: UILabel!
    @IBOutlet weak var SecondBeaconLabel: UILabel!
    @IBOutlet weak var Principle: UIImageView!
    
    var count: Int = 0
    var error_A: Int = 0
    var error_B: Int = 0
    var error_C: Int = 0
    var error_D: Int = 0
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //條件beacon power:-30db, ~1.5m rssi= 91 設為閥值  && ($0.rssi > -92)
        let sortedBeacons = beacons.filter{ ($0.accuracy > 0.0) }.sorted(){ $0.accuracy < $1.accuracy }
        
        count = count + 1
        print("BeaconCount:\(sortedBeacons.count)","TotalCount:",count)
       
        //加入時間
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("hours = \(hour):\(minutes):\(seconds)")
        
        
        if (sortedBeacons.count == 0){ // detect No beacon
         
            Principle.image = #imageLiteral(resourceName: "A∩B Original")
            FirstBeaconLabel.text = "1st.Beacon : "
            SecondBeaconLabel.text = "2nd.Beacon : "
            //error_A 任一顆beacon都沒讀到
            error_A = error_A + 1
            print("CountA for Error", error_A)
            
        }else if (sortedBeacons.count == 1){ //detect one beacon
         
            let FirstBeacon = sortedBeacons[0] as CLBeacon
         
            if (FirstBeacon.major == 58791){
         
                print("1stBeacon=\(FirstBeacon.major)", "RSSI=", FirstBeacon.rssi)
                FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                SecondBeaconLabel.text = "2nd.Beacon : "
         
                Principle.image = #imageLiteral(resourceName: "A-1")
                
                //error_B 只讀到beacon 58791
                error_B = error_B + 1
                print("CountB for Error", error_B)
         
            }else if (FirstBeacon.major == 44057){
         
                print("1stBeacon=\(FirstBeacon.major)", "RSSI=", FirstBeacon.rssi)
                FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                SecondBeaconLabel.text = "2nd.Beacon : "
         
                Principle.image = #imageLiteral(resourceName: "B-1")
                
                //error_C 只讀到beacon 44057
                error_C = error_C + 1
                print("CountC for Error", error_C)
            }
         
         }else if(sortedBeacons.count == 2){ //detect two beacon
            
            let FirstBeacon = sortedBeacons[0] as CLBeacon
            let SecondBeacon = sortedBeacons[1] as CLBeacon
            
            //顯示距離遠到近的iBeacon
            if (FirstBeacon.major == 58791 && SecondBeacon.major == 44057)||(FirstBeacon.major == 44057 && SecondBeacon.major == 58791){ //判斷為兩顆iBeacon
                
                print("1stBeacon=\(FirstBeacon.major)", "RSSI=", FirstBeacon.rssi)
                print("2ndBeacon=\(SecondBeacon.major)", "RSSI=", SecondBeacon.rssi)
                
                FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                SecondBeaconLabel.text = "2nd.Beacon : \(SecondBeacon.major)"
                
                Principle.image = #imageLiteral(resourceName: "A∩B-1")
            }
            
        }else if (sortedBeacons.count != 0 && sortedBeacons.count != 1 && sortedBeacons.count != 2 ){ //若 不為一顆Beacon 偵測錯誤
            //若Count讀到的不是0 1 2
            error_D = error_D + 1
            print("CountD for Error", error_D)
        }
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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeacons(in: self.beaconRegion)
    }
    
}
