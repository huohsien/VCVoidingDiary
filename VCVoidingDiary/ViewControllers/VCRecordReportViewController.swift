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
    @IBOutlet weak var recordTypeLabel: UILabel!
    @IBOutlet weak var recordVolumeLabel: UILabel!
    
    
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

class VCRecordReportViewController: UIViewController {

    let isUsingTestData = false

    @IBOutlet weak var tableView: UITableView!
    
    var recordMOs : [NSManagedObject] = []
    var records : [Dictionary<String,Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self;
        tableView.dataSource = self;
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isUsingTestData {
            
            records = [
                ["day" : "1", "time": "020", "voidingVolume" : "0", "intakeVolume" : "1000", "isNightTime": "false"],
                ["day" : "1", "time": "0910", "voidingVolume" : "100", "intakeVolume" : "0", "isNightTime": "false"],
                ["day" : "1", "time": "1220", "voidingVolume" : "0", "intakeVolume" : "500", "isNightTime": "false"],
                ["day" : "1", "time": "2310", "voidingVolume" : "250", "intakeVolume" : "0", "isNightTime": "true"]
            ];
            
        } else {
            
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Record")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                recordMOs = try managedContext!.fetch(fetchRequest)
                for data in recordMOs {
                    let keys = Array(data.entity.attributesByName.keys);
                    let dict = data.dictionaryWithValues(forKeys: keys);
                    records.append(dict);
                }
            } catch let error as NSError {
                DDLogError("Could not fetch. \(error), \(error.userInfo)")
            }
            DDLogDebug("number of records = \(records.count)")
            
        }
    }
    
}

extension VCRecordReportViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == (records.count - 1) {
            VCHelper.showAlert(title: "請問您是要修改記錄", message: "") {
                (isCancelled: Bool) in
                if isCancelled {
                    DDLogDebug("cancel");
                } else {
                    DDLogDebug("ok");
                }
            }
            return indexPath;
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return (indexPath.row == (records.count - 1))
    }
}

extension VCRecordReportViewController : UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordReportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecordReportCellIdentifier", for: indexPath) as! VCRecordReportTableViewCell
        
        let record = records[indexPath.row];
        let time  = Int(String(format: "%@", record["time"] as! CVarArg))!
        let hour = time / 100
        let min = time % 100
        recordReportTableViewCell.timeLabel.text = (hour < 10 ? "0" : "") + "\(hour):" + (min < 10 ? "0" : "") + "\(min)";
        
        let voidingVolume = Int(String(format: "%@", record["voidingVolume"] as! CVarArg))!
        let intakeVolume = Int(String(format: "%@", record["intakeVolume"] as! CVarArg))!
        if voidingVolume > 0 {
            recordReportTableViewCell.recordTypeLabel.text = "排尿：";
            recordReportTableViewCell.recordVolumeLabel.text = "\(voidingVolume) cc";
        }
        if intakeVolume > 0 {
            recordReportTableViewCell.recordTypeLabel.text = "喝水：";
            recordReportTableViewCell.recordVolumeLabel.text = "\(intakeVolume) cc";
            
        }
        
        var isNightTime = false;
        
        if let isNightTimeInt = Int(String(format: "%@", record["isNightTime"] as! CVarArg)) {
            isNightTime = isNightTimeInt == 0 ? false : true;
        } else {
            isNightTime = Bool(String(format: "%@", record["isNightTime"] as! CVarArg))!
        }
        
        if isNightTime {
            recordReportTableViewCell.backgroundColor = UIColor.lightGray;
        }
//        recordReportTableViewCell.recordButton.setTitleColor(recordReportTableViewCell.recordButton.titleLabel?.textColor.withAlphaComponent(0.85), for: .highlighted);
    
        return recordReportTableViewCell;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DDLogDebug("row : \(indexPath.row) is selected. the number of records is \(records.count)")
        if indexPath.row == (records.count - 1) {
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            DDLogError("Should never come here!")
        }
    }

}
