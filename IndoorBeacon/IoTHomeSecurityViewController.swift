//
//  IoTHomeSecurityViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/3/28.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit

class IoTHomeSecurityViewController: UIViewController, ESTBeaconManagerDelegate {

  
    @IBOutlet weak var UIImage: UIImageView!
   
    var count: Int = 0
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //條件beacon power:-30db
        let sortedBeacons = beacons.filter{ $0.accuracy > 0.0 }.sorted(){ $0.accuracy < $1.accuracy }
        
        if let nearest = sortedBeacons.first {
            
            if nearest.major.int32Value == 55880 {
            
                UIImage.image = #imageLiteral(resourceName: "candylarge")
                count = count + 1
                print("TotalCount:",count)
                
                if count == 30 {
                    
                    print("Alarm")
                    //使用UIAlertController來當提醒功能
                    let myAlert = UIAlertController(title: "IoT Home Security Alart", message: "鑰匙,錢包和手機是否記得拿！", preferredStyle:.alert)
                    //產生Ok Button, 來當作DismissViewControllerAnimated, 將警告控制器從畫面上移除
                    let okAction = UIAlertAction(title: "OK" , style: .default , handler:{ (action:UIAlertAction) -> () in
                        print("OK")
                        self.dismiss(animated: true, completion:nil)})
                    //把OK按鈕加到警告控制器裡面
                    myAlert.addAction(okAction)
                    //推出警告控制器
                    self.present(myAlert, animated: true, completion: nil)
                    //Release count
                    count = 0
                    
                }
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
