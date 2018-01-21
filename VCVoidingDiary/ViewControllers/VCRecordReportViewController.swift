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

class VCRecordReportViewController: UIViewController {
    
    //MARK:- Variables
    
    let isUsingTestData = false
    var indexPathScrolledCentered : IndexPath? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    var recordMOs : [NSManagedObject] = []
    var records : [Dictionary<String,Any>] = []
    
    //MARK:- View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self;
        tableView.dataSource = self;
        
        VCHelper.empty(forTableView: self.tableView, showMessage: "稍等...", inFontSize:64.0, andFontName:"cwTexKai")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isUsingTestData {
            
            records = [
                ["time": "2018-01-16 00:17:20 +0800", "voidingVolume" : "0", "intakeVolume" : "1000", "isNightTime": "false"],
                ["time": "2018-01-16 10:17:20 +0800", "voidingVolume" : "100", "intakeVolume" : "0", "isNightTime": "false"],
                ["time": "2018-01-16 15:17:20 +0800", "voidingVolume" : "0", "intakeVolume" : "500", "isNightTime": "false"],
                ["time": "2018-01-16 23:17:20 +0800", "voidingVolume" : "250", "intakeVolume" : "0", "isNightTime": "true"]
            ];
            
        } else {
            reloadTable()
        }
    }
    
    //MARK:- Tool methods
    
    func reloadTable() {
        fetchAllRecords()
        tableView.reloadData()
        tableView.backgroundView = nil
        
        if let indexPath = indexPathScrolledCentered {
            DDLogDebug("try to scroll the edited cell")
            self.tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
        }
    }
    
    func fetchAllRecords() {
        
        records.removeAll()
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<Record>(entityName: "Record")
        let sort = NSSortDescriptor(key: #keyPath(Record.time), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.returnsObjectsAsFaults = false
        var count = 0
        do {
            recordMOs = try managedContext!.fetch(fetchRequest)
            for data in recordMOs {
                let keys = Array(data.entity.attributesByName.keys);
                let dict = data.dictionaryWithValues(forKeys: keys);
                records.append(dict);
                
                if data == appDelegate.managedObjectInEdit {
                    self.indexPathScrolledCentered = IndexPath(row: count, section: 0)
                    appDelegate.managedObjectInEdit = nil
                }
                count += 1
            }
        } catch let error as NSError {
            DDLogError("Could not fetch. \(error), \(error.userInfo)")
        }
        DDLogDebug("number of records = \(records.count)")
    }
}

//MARK:- Table delegates

extension VCRecordReportViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
       
        if checkIfEditable(at: indexPath) {
            return indexPath;
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return checkIfEditable(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DDLogDebug("row : \(indexPath.row) is selected. the number of records is \(records.count)")
        
        if checkIfEditable(at: indexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            VCHelper.showAlert(title: "請問您是要刪除紀錄嗎", message: "") {
                (isCancelled : Bool) in
                if isCancelled {
                    // modify record by go through the navigation chain again with flagging object
                    
                    self.appDelegate.managedObjectInEdit = self.recordMOs[indexPath.row]
                    self.navigationController?.popViewController(animated: true)
                    
                } else {
                    // delete record
                    self.appDelegate.managedObjectContext!.delete(self.recordMOs[indexPath.row]);
                    self.appDelegate.saveContext()
                    self.reloadTable()
                    DDLogError("Error in deleting record")
                }
                
            }
        } else {
            DDLogError("Should never come here!")
        }
    }
    func checkIfEditable(at: IndexPath) -> Bool {
        let date = Date().timeIntervalSince1970;
        let recordTime = (records[at.row]["time"] as! NSDate).timeIntervalSince1970
        let timeDifferenceInMinutes = floor((date - recordTime) / 60.0);
        DDLogDebug("time difference = \(timeDifferenceInMinutes) minutes")
        return (timeDifferenceInMinutes < 30)
    }

}

//MARK:- Table data source

extension VCRecordReportViewController : UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordReportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecordReportCellIdentifier", for: indexPath) as! VCRecordReportTableViewCell
        
        let record = records[indexPath.row];
        
        // convert record["time"] to string to accommodate both real and test data
        
        let timeString  = (String(format: "%@", record["time"] as! CVarArg))
        
        let dateFormatter = DateFormatter();
        dateFormatter.timeZone = TimeZone(identifier: "Asia / Taipei")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        // convert time to Date type!
        let time = dateFormatter.date(from: timeString)
        
        // prepare integers for labels
        let calendar = Calendar.current;
        let hour = calendar.component(.hour, from: time!)
        let min = calendar.component(.minute, from: time!)
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
        } else {
            recordReportTableViewCell.backgroundColor = UIColor.white;
        }
//        recordReportTableViewCell.recordButton.setTitleColor(recordReportTableViewCell.recordButton.titleLabel?.textColor.withAlphaComponent(0.85), for: .highlighted);
        if checkIfEditable(at: indexPath) {
            recordReportTableViewCell.isEditableLabel.isHidden = false;
        } else {
            recordReportTableViewCell.isEditableLabel.isHidden = true;
        }
        return recordReportTableViewCell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count;
    }
}
