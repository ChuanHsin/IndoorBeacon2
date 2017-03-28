//
//  ExpOneBeaconViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/3/14.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit

class ExpOneBeaconViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var FirstBeaconLabel: UILabel!
    @IBOutlet weak var Principle: UIImageView!
        
        var count: Int = 0
        var error: Int = 0
    
        let beaconManager = ESTBeaconManager()
        let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
        
        func startRangingBeacons() {
            beaconManager.startRangingBeacons(in: self.beaconRegion)
        }
        
        func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
            //條件beacon power:-30db
            let sortedBeacons = beacons.filter{ $0.accuracy > 0.0 }.sorted(){ $0.accuracy < $1.accuracy }
            
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
                
                Principle.image = #imageLiteral(resourceName: "Apple")
                FirstBeaconLabel.text = "1st.Beacon : "
                error = error + 1
                print("Count for Error", error)
                
            }else if (sortedBeacons.count == 1){ //detect one beacon
                
                //let FirstBeacon = sortedBeacons[0] as CLBeacon
                if let FirstBeacon = sortedBeacons.first{
                
                if (FirstBeacon.major == 58791){
                    
                    print("1stBeacon=\(FirstBeacon.major)", "RSSI=", FirstBeacon.rssi)
                    FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                    
                    Principle.image = #imageLiteral(resourceName: "lemonYellow")
                    
                }
 
                /*
                     if (FirstBeacon.major == 44057){
                     
                     print("1stBeacon=\(FirstBeacon.major)", "RSSI=", FirstBeacon.rssi)
                     FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                     
                     Principle.image = #imageLiteral(resourceName: "beetrootRed")
                     
                     }
                */
                
                }
            }else if (sortedBeacons.count != 1 ){ //若 不為一顆Beacon 偵測錯誤率
                error = error + 1
                print("Count for Error", error)
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
