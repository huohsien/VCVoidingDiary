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
    @IBOutlet weak var voidingRecordButton: UIButton!
    @IBOutlet weak var intakeRecordButton: UIButton!
    
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
        
        tableView.register(VCRecordReportTableViewCell.self, forCellReuseIdentifier: "RecordReportCellIdentifier")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordReportCellIdentifier", for: indexPath) as! VCRecordReportTableViewCell
        
        let record = records[indexPath.row];
//        cell.timeLabel.text = record.value(forKey: "time") as? String;
//        cell.voidingRecordButton.titleLabel?.text = record.value(forKey: "voidingVolume") as? String;
        cell.intakeRecordButton.titleLabel?.text = record.value(forKey: "intakeVolume") as? String;

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count;
    }

}
