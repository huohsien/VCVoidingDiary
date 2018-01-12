//
//  VCRecordReportViewController.swift
//  VCVoidingDiary
//
//  Created by victor on 10/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit
import CocoaLumberjack
import CoreData

class VCRecordReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class VCRecordReportViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var records : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self;
        tableView.dataSource = self;
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Record")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            records = try managedContext!.fetch(fetchRequest)
            for data in records {
                if let intakeVolume = data.value(forKey: "intakeVolume") as? NSNumber {
                    DDLogDebug("intakeVolume = \(intakeVolume)")
                } else {
                    DDLogDebug("failed!")
                }
            }
        } catch let error as NSError {
            DDLogError("Could not fetch. \(error), \(error.userInfo)")
        }
        DDLogDebug("number of records = \(records.count)")
    }
}

extension VCRecordReportViewController : UITableViewDelegate {
    
}

extension VCRecordReportViewController : UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordReportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecordReportCellIdentifier", for: indexPath) as! VCRecordReportTableViewCell
        
        let record = records[indexPath.row];
        
        let time = record.value(forKey: "time") as! Int
        let hour = time / 100
        let min = time % 100
        recordReportTableViewCell.timeLabel.text = (hour < 10 ? "0" : "") + "\(hour):" + (min < 10 ? "0" : "") + "\(min)";
        
        let voidingVolume = record.value(forKey: "voidingVolume") as! NSNumber
        let intakeVolume = record.value(forKey: "intakeVolume") as! NSNumber
        if voidingVolume.int16Value > 0 {
            recordReportTableViewCell.recordButton.setTitle("排尿：\(voidingVolume)CC", for: .normal);
        }
        if intakeVolume.int16Value > 0 {
            recordReportTableViewCell.recordButton.setTitle("喝水：\(intakeVolume)CC", for: .normal);
        }
        let isNightTime = record.value(forKey: "isNightTime") as! Bool
        if isNightTime {
            recordReportTableViewCell.backgroundColor = UIColor.lightGray;
        }
        recordReportTableViewCell.recordButton.setTitleColor(recordReportTableViewCell.recordButton.titleLabel?.textColor.withAlphaComponent(0.85), for: .highlighted);
    
        return recordReportTableViewCell;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count;
    }

}
