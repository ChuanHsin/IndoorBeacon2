//
//  PositionDetectViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/2/22.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit

class PositionDetectViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var BeaconFirstLabel: UILabel!
    @IBOutlet weak var BeaconSecondLabel: UILabel!
    @IBOutlet weak var BeaconThirdLabel: UILabel!
    
    @IBOutlet weak var FirstImageView: UIImageView!
    @IBOutlet weak var SecondImageView: UIImageView!
    @IBOutlet weak var ThirdImageView: UIImageView!
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        // _ = beacons.filter(){ $0.accuracy > 0.0 }
        // ($0.accuracy > 0.0)&&(1.5 > $0.accuracy)抓取0~1.5的值
        let sortedBeacons = beacons.filter{ ($0.accuracy > 0.0)&&( 1.5 > $0.accuracy) }.sorted(){ $0.accuracy < $1.accuracy }
        
        print(sortedBeacons.count)
            
        if (sortedBeacons.count == 0){ // detect No beacon
            
            FirstImageView.image = #imageLiteral(resourceName: "Apple")
            SecondImageView.image =  #imageLiteral(resourceName: "Apple")
            BeaconFirstLabel.text = "Beacon-1st : "
            BeaconSecondLabel.text = "Beacon-2nd : "
            
        }else if (sortedBeacons.count == 1){ //detect one beacon
            
            let FirstBeacon = sortedBeacons[0] as CLBeacon
            
            if (FirstBeacon.major == 58791){
                
                print(FirstBeacon.major)
                BeaconFirstLabel.text = "Beacon-1st : \(FirstBeacon.major)"
                BeaconSecondLabel.text = "Beacon-2nd : "
                
                FirstImageView.image = #imageLiteral(resourceName: "lemonYellow")
                SecondImageView.image = #imageLiteral(resourceName: "Apple")
                
            }else if (FirstBeacon.major == 44057){
                print(FirstBeacon.major)
                BeaconFirstLabel.text = "Beacon-1st : \(FirstBeacon.major)"
                BeaconSecondLabel.text = "Beacon-2nd : "
                
                FirstImageView.image = #imageLiteral(resourceName: "beetrootRed")
                SecondImageView.image = #imageLiteral(resourceName: "Apple")
            }

        }else if(sortedBeacons.count == 2){ //detect two beacon
            
            let FirstBeacon = sortedBeacons[0] as CLBeacon
            let SecondBeacon = sortedBeacons[1] as CLBeacon
            //let ThirdBeacon = sortedBeacons[2] as CLBeacon
            print(FirstBeacon.major)
            print(SecondBeacon.major)
            //print(ThirdBeacon.major)
            BeaconFirstLabel.text = "Beacon-1st : \(FirstBeacon.major)"
            BeaconSecondLabel.text = "Beacon-2nd : \(SecondBeacon.major)"
            //BeaconThirdLabel.text = "Beacon-3rd : \(ThirdBeacon.major)"
            
            if (FirstBeacon.major == 58791){
                FirstImageView.image = #imageLiteral(resourceName: "lemonYellow")
                if (SecondBeacon.major == 44057){
                    SecondImageView.image = #imageLiteral(resourceName: "beetrootRed")
                }
            }else if (FirstBeacon.major == 44057){
                FirstImageView.image = #imageLiteral(resourceName: "beetrootRed")
                if (SecondBeacon.major == 58791) {
                    SecondImageView.image = #imageLiteral(resourceName: "lemonYellow")
                }
            }else if (FirstBeacon.major == 58791 && SecondBeacon.major == 44057)||(FirstBeacon.major == 44057 &&            SecondBeacon.major == 58791){
                FirstImageView.image = #imageLiteral(resourceName: "lemonYellow")
                SecondImageView.image = #imageLiteral(resourceName: "beetrootRed")
            }else{
                FirstImageView.image = #imageLiteral(resourceName: "Apple")
                SecondImageView.image =  #imageLiteral(resourceName: "Apple")
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
