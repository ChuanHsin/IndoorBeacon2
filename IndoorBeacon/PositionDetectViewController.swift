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
    
    @IBOutlet weak var Principle: UIImageView!
    
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
            ThirdImageView.image = #imageLiteral(resourceName: "Apple")
            Principle.image = #imageLiteral(resourceName: "A∩B∩C-Original")
            
            BeaconFirstLabel.text = "1st.Beacon : "
            BeaconSecondLabel.text = "2nd.Beacon : "
            BeaconThirdLabel.text = "3rd.Beacon : "
            
            
        }else if (sortedBeacons.count == 1){ //detect one beacon
            
            let FirstBeacon = sortedBeacons[0] as CLBeacon
            
            if (FirstBeacon.major == 58791){
                
                print(FirstBeacon.major)
                BeaconFirstLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                BeaconSecondLabel.text = "2nd.Beacon : "
                BeaconThirdLabel.text = "3rd.Beacon : "
                
                FirstImageView.image = #imageLiteral(resourceName: "lemonYellow")
                SecondImageView.image = #imageLiteral(resourceName: "Apple")
                ThirdImageView.image = #imageLiteral(resourceName: "Apple")
                Principle.image = #imageLiteral(resourceName: "A")
                
            }else if (FirstBeacon.major == 44057){
                
                print(FirstBeacon.major)
                BeaconFirstLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                BeaconSecondLabel.text = "2nd.Beacon : "
                BeaconThirdLabel.text = "3rd.Beacon : "
                
                FirstImageView.image = #imageLiteral(resourceName: "beetrootRed")
                SecondImageView.image = #imageLiteral(resourceName: "Apple")
                ThirdImageView.image = #imageLiteral(resourceName: "Apple")
                Principle.image = #imageLiteral(resourceName: "B")
                
            }else if (FirstBeacon.major == 55880){
                
                print(FirstBeacon.major)
                BeaconFirstLabel.text = "1st.Beacon : \(FirstBeacon.major)"
                BeaconSecondLabel.text = "2nd.Beacon : "
                BeaconThirdLabel.text = "3rd.Beacon : "
                
                FirstImageView.image = #imageLiteral(resourceName: "candylarge")
                SecondImageView.image = #imageLiteral(resourceName: "Apple")
                ThirdImageView.image = #imageLiteral(resourceName: "Apple")
                Principle.image = #imageLiteral(resourceName: "C")
            }

        }else if(sortedBeacons.count == 2){ //detect two beacon
            
            let FirstBeacon = sortedBeacons[0] as CLBeacon
            let SecondBeacon = sortedBeacons[1] as CLBeacon
            //let ThirdBeacon = sortedBeacons[2] as CLBeacon
            print(FirstBeacon.major)
            print(SecondBeacon.major)
            //print(ThirdBeacon.major)
            BeaconFirstLabel.text = "1st.Beacon : \(FirstBeacon.major)"
            BeaconSecondLabel.text = "2nd.Beacon : \(SecondBeacon.major)"
            //BeaconThirdLabel.text = "3rd.Beacon : \(ThirdBeacon.major)"
            
            //顯示距離遠到近的iBeacon
            if (FirstBeacon.major == 58791 && SecondBeacon.major == 44057)||(FirstBeacon.major == 44057 && SecondBeacon.major == 58791){ //判斷為兩顆iBeacon
                FirstImageView.image = #imageLiteral(resourceName: "lemonYellow")
                SecondImageView.image = #imageLiteral(resourceName: "beetrootRed")
                ThirdImageView.image = #imageLiteral(resourceName: "Apple")
                Principle.image = #imageLiteral(resourceName: "A∩B")
                
            }else if (FirstBeacon.major == 58791 && SecondBeacon.major == 55880)||(FirstBeacon.major == 55880 && SecondBeacon.major == 58791){
                FirstImageView.image = #imageLiteral(resourceName: "lemonYellow")
                SecondImageView.image = #imageLiteral(resourceName: "candylarge")
                ThirdImageView.image = #imageLiteral(resourceName: "Apple")
                Principle.image = #imageLiteral(resourceName: "A∩C")
                
            }else if (FirstBeacon.major == 44057 && SecondBeacon.major == 55880)||(FirstBeacon.major == 55880 && SecondBeacon.major == 44057){
                FirstImageView.image = #imageLiteral(resourceName: "beetrootRed")
                SecondImageView.image = #imageLiteral(resourceName: "candylarge")
                ThirdImageView.image = #imageLiteral(resourceName: "Apple")
                Principle.image = #imageLiteral(resourceName: "B∩C")
            }
            
        }else if(sortedBeacons.count == 3){ //detect three beacon in same region
            
            let FirstBeacon = sortedBeacons[0] as CLBeacon
            let SecondBeacon = sortedBeacons[1] as CLBeacon
            let ThirdBeacon = sortedBeacons[2] as CLBeacon
            print(FirstBeacon.major)
            print(SecondBeacon.major)
            print(ThirdBeacon.major)
            BeaconFirstLabel.text = "1st.Beacon : \(FirstBeacon.major)"
            BeaconSecondLabel.text = "2nd.Beacon : \(SecondBeacon.major)"
            BeaconThirdLabel.text = "3rd.Beacon : \(ThirdBeacon.major)"
            
            if (FirstBeacon.major == 58791 && SecondBeacon.major == 44057 && ThirdBeacon.major == 55880)||(FirstBeacon.major == 58791 && SecondBeacon.major == 55880 && ThirdBeacon.major == 44057)||(FirstBeacon.major == 44057 && SecondBeacon.major == 58791 && ThirdBeacon.major == 55880)||(FirstBeacon.major == 44057 && SecondBeacon.major == 55880 && ThirdBeacon.major == 58791)||(FirstBeacon.major == 55880 && SecondBeacon.major == 58791 && ThirdBeacon.major == 44057)||(FirstBeacon.major == 55880 && SecondBeacon.major == 44057 && ThirdBeacon.major == 58791){ //判斷為三顆iBeacon
                FirstImageView.image = #imageLiteral(resourceName: "lemonYellow")
                SecondImageView.image = #imageLiteral(resourceName: "beetrootRed")
                ThirdImageView.image = #imageLiteral(resourceName: "candylarge")
                Principle.image = #imageLiteral(resourceName: "A∩B∩C")
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
