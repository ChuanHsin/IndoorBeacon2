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
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //條件beacon power:-30db, ~1.5m
        let sortedBeacons = beacons.filter{ $0.accuracy > 0.0 }.sorted(){ $0.accuracy < $1.accuracy }
        
        count = count + 1
        print("BeaconCount:\(sortedBeacons.count)","TotalCount:",count)
       
         if (sortedBeacons.count == 0){ // detect No beacon
         
         Principle.image = #imageLiteral(resourceName: "A∩B Original")
         FirstBeaconLabel.text = "1st.Beacon : "
         SecondBeaconLabel.text = "2nd.Beacon : "
         
         }else if (sortedBeacons.count == 1){ //detect one beacon
         
         let FirstBeacon = sortedBeacons[0] as CLBeacon
         
         if (FirstBeacon.major == 58791){
         
         print("1stBeacon=\(FirstBeacon.major)", "RSSI=", FirstBeacon.rssi)
         FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
         SecondBeaconLabel.text = "2nd.Beacon : "
         
         Principle.image = #imageLiteral(resourceName: "A-1")
         
         }else if (FirstBeacon.major == 44057){
         
         print("1stBeacon=\(FirstBeacon.major)", "RSSI=", FirstBeacon.rssi)
         FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
         SecondBeaconLabel.text = "2nd.Beacon : "
         
         Principle.image = #imageLiteral(resourceName: "B-1")
         
         }
         
         }else if(sortedBeacons.count == 2){ //detect two beacon
            
            let FirstBeacon = sortedBeacons[0] as CLBeacon
            let SecondBeacon = sortedBeacons[1] as CLBeacon
            
            print("1stBeacon=\(FirstBeacon.major)", "RSSI=", FirstBeacon.rssi)
            print("2ndBeacon=\(SecondBeacon.major)", "RSSI=", SecondBeacon.rssi)
            
            FirstBeaconLabel.text = "1st.Beacon : \(FirstBeacon.major)"
            SecondBeaconLabel.text = "2nd.Beacon : \(SecondBeacon.major)"
            
            //顯示距離遠到近的iBeacon
            if (FirstBeacon.major == 58791 && SecondBeacon.major == 44057)||(FirstBeacon.major == 44057 && SecondBeacon.major == 58791){ //判斷為兩顆iBeacon
                
                Principle.image = #imageLiteral(resourceName: "A∩B-1")
                
            }
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
