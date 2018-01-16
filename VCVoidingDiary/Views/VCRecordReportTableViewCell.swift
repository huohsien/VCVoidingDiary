//
//  VCRecordReportTableViewCell.swift
//  VCVoidingDiary
//
//  Created by victor on 16/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit

class VCRecordReportTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recordTypeLabel: UILabel!
    @IBOutlet weak var recordVolumeLabel: UILabel!
    @IBOutlet weak var isEditableLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if #available(iOS 9.0, *) {
            self.timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: UIFont.Weight.bold)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
