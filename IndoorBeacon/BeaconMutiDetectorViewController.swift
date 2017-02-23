//
//  BeaconMutiDetectorViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/2/21.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit

class BeaconMutiDetectorViewController: UIViewController,ESTBeaconManagerDelegate{
    

    @IBOutlet weak var BeaconFirstLabel: UILabel!
    @IBOutlet weak var BeaconSecondLabel: UILabel!
    @IBOutlet weak var BeaconThirdLabel: UILabel!
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        // _ = beacons.filter(){ $0.accuracy > 0.0 }
        // ($0.accuracy > 0.0)&&(1.5 > $0.accuracy)抓取0~1.5的值
        let sortedBeacons = beacons.filter{ ($0.accuracy > 0.0)&&(1.5 > $0.accuracy) }.sorted(){ $0.accuracy < $1.accuracy }
        
        print(sortedBeacons.count)
        
        if(sortedBeacons.count > 0)&&(sortedBeacons.count < 4) {
            
            if((sortedBeacons.count > 0)&&(sortedBeacons.count < 2)){ //detect only one beacon
                let FirstBeacon = sortedBeacons[0] as CLBeacon
                //let SecondBeacon = sortedBeacons[1] as CLBeacon
                //let ThirdBeacon = sortedBeacons[2]
                print(FirstBeacon.major)
                //print(SecondBeacon.major)
                //print(ThirdBeacon.major)
                BeaconFirstLabel.text = "Beacon-1st : \(FirstBeacon.major)"
                //BeaconSecondLabel.text = "Beacon-2nd : \(SecondBeacon.major)"
            }else if((sortedBeacons.count > 1)&&(sortedBeacons.count < 3)){ //detect two beacon
                let FirstBeacon = sortedBeacons[0] as CLBeacon
                let SecondBeacon = sortedBeacons[1] as CLBeacon
                //let ThirdBeacon = sortedBeacons[2]
                print(FirstBeacon.major)
                print(SecondBeacon.major)
                //print(ThirdBeacon.major)
                BeaconFirstLabel.text = "Beacon-1st : \(FirstBeacon.major)"
                BeaconSecondLabel.text = "Beacon-2nd : \(SecondBeacon.major)"
            }else if((sortedBeacons.count > 2)&&(sortedBeacons.count < 4)){ //detect three beacon
                let FirstBeacon = sortedBeacons[0] as CLBeacon
                let SecondBeacon = sortedBeacons[1] as CLBeacon
                let ThirdBeacon = sortedBeacons[2] as CLBeacon
                print(FirstBeacon.major)
                print(SecondBeacon.major)
                print(ThirdBeacon.major)
                BeaconFirstLabel.text = "Beacon-1st : \(FirstBeacon.major)"
                BeaconSecondLabel.text = "Beacon-2nd : \(SecondBeacon.major)"
                BeaconThirdLabel.text = "Beacon-3rd : \(ThirdBeacon.major)"
            }else{
                BeaconFirstLabel.text = "Beacon-1st : "
                BeaconSecondLabel.text = "Beacon-2nd : "
                BeaconThirdLabel.text = "Beacon-3rd : "
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
        //print("will")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeacons(in: self.beaconRegion)
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
