//
//  BeaconListViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/1/16.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit

class BeaconListViewController: UIViewController, ESTBeaconManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var MytableView: UITableView!

    //let animalArray = ["cat","dog","elephant","rabbit"]
    
    var sortedBeacons : [CLBeacon] = []
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        beaconManager.requestWhenInUseAuthorization()
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
   
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        // _ = beacons.filter(){ $0.accuracy > 0.0 }
        // ($0.accuracy > 0.0)&&(1.5 > $0.accuracy)抓取0~1.5的值
        sortedBeacons = beacons.filter(){ ($0.accuracy > 0.0)&&(1.5 > $0.accuracy) }.sorted(){ $0.accuracy < $1.accuracy }
        
        MytableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return sortedBeacons.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell()
        let beacon : CLBeacon = sortedBeacons[indexPath.row]
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath )
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BeaconListCell
        
        cell.Major.text = "Major = " + beacon.major.int32Value.description
        cell.minor.text = "minor = " + beacon.minor.int32Value.description
        cell.RSSI.text =  "RSSI = " + beacon.rssi.description
        cell.Dist.text = "Dist = " + Float(beacon.accuracy).description
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.beaconManager.delegate = self
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
