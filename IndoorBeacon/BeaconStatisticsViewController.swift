//
//  BeaconStatisticsViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/2/9.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit

class BeaconStatisticsViewController: UIViewController, ESTBeaconManagerDelegate {

    @IBOutlet weak var RSSILabel: UILabel!
    @IBOutlet weak var DistLabel: UILabel!
    @IBOutlet weak var AverageRSSILabel: UILabel!
    @IBOutlet weak var AverageDistLabel: UILabel!
    @IBOutlet weak var BeaconImage: UIImageView!
    
    var SumRSSI = 0
    var SumDist: Double = 0
    var count = 0
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        beaconManager.requestWhenInUseAuthorization()
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon],in region: CLBeaconRegion) {
        
        //let sortedBeacons = beacons.filter{ $0.accuracy > 0.0 }.sorted{ $0.accuracy < $1.accuracy }
        // ($0.accuracy > 0.0)&&(1.5 > $0.accuracy)抓取0~1.5的值
        let sortedBeacons = beacons.filter(){ ($0.accuracy > 0.0)&&(1.5 > $0.accuracy) }.sorted(){ $0.accuracy < $1.accuracy }
        
        
        if let nearest = sortedBeacons.first {
            
            if nearest.major.int32Value == 58791 {
                
                let Distance = round((nearest.accuracy)*1000)/1000 //四捨五入取至小數第三位
                
                RSSILabel.text  = "RSSI = \(nearest.rssi)"
                DistLabel.text  = "Dist = \(Distance) m"
                //DistLabel.text  = "Dist = \(Float(nearest.accuracy))"
                
                print("RSSI  = \(nearest.rssi)")
                print("Dist = \(Distance) m")
                //print("Dist = \(Float(nearest.accuracy)) m")
                
                count = count + 1
                SumRSSI = SumRSSI + (nearest.rssi)
                
                
                SumDist = Double(nearest.accuracy) + SumDist
                
                print(nearest.accuracy)
                print(Float(SumDist))
                
                AverageRSSILabel.text = "AverageRSSI = \(Float(SumRSSI)/Float(count))"
                AverageDistLabel.text = "AverageDist = \(Float(SumDist)/Float(count))"
                
                print(Float(count))
                print(Float(SumRSSI)/Float(count))
                
                BeaconImage.image = #imageLiteral(resourceName: "lemonYellow")
                
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
