//
//  BeaconListCell.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/1/16.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit

class BeaconListCell: UITableViewCell {

    @IBOutlet weak var Major: UILabel!
    @IBOutlet weak var minor: UILabel!
    @IBOutlet weak var RSSI: UILabel!
    @IBOutlet weak var Dist: UILabel!

    override func awakeFromNib() {
               super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
