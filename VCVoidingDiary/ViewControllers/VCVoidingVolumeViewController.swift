//
//  VCVoidingVolumeViewController.swift
//  VCVoidingDiary
//
//  Created by victor on 09/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit
import CocoaLumberjack
import CoreData

class VCVoidingVolumeViewController: UIViewController {

    var volume : Int = 0
    private var digitPlace : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        space = 12.0;
        
        if appDelegate.managedObjectInEdit != nil {
            self.title = "修改(紀錄項目)"
        } else {
            self.title = "紀錄項目"
        }
    }
    
    
    @IBOutlet weak var volumeLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBOutlet var spacers: [NSLayoutConstraint]!
    
    var space: CGFloat = 8.0 {
        didSet {
            spacers.forEach {
                $0.constant = space;
            }
        }
    }
    
    @IBAction func keyHandler(_ sender: UIButton) {
        
        let string = (sender.titleLabel?.text)!;
        DDLogDebug("pressed key : \(string)");
        if let number : Int = Int(string){
            DDLogDebug("integer number of the pressed key : \(number) and the current digit place is \(digitPlace)");
            if (digitPlace <= 3) {
                volume *= 10;
                volume += number;
                digitPlace += 1;
                self.volumeLabel.text = String(volume);
            }
        } else if (string.contains("清除")) {
            DDLogDebug("清除. digit place reset to 0");
            digitPlace = 0;
            volume = 0;
            self.volumeLabel.text = String(volume);
        } else if (string.contains("完成")) {
            DDLogDebug("完成. entered volume is \(volume)");
            
            if appDelegate.managedObjectInEdit != nil {
                
            } else  {
                addNewRecord();
                let navigationController = self.presentingViewController as? UINavigationController;
                dismiss(animated: false, completion: {
                    navigationController?.popToRootViewController(animated: true);
                })
            }
        }
    }
    
    func addNewRecord() {
        
        if volume <= 0 {
            return
        }
        DDLogDebug("add a new record")
        let moc = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Record", in: moc!)!
        let record = NSManagedObject(entity: entity, insertInto: moc)
//        let record = Record(day: 1, time: VCHelper.getCurrentTimeInFourDigitsInteger(), voidingVolume: volume, intakeVolume: 0, isNightTime: appDelegate.isNightTime);

        record.setValue(NSDate(), forKey: "time");
        record.setValue(volume, forKey: "voidingVolume");
        record.setValue(0, forKey: "intakeVolume");
        record.setValue(appDelegate.isNightTime, forKey: "isNightTime");
        
        do {
            try moc?.save()
        } catch let error as NSError {
            DDLogError("Could not save. \(error), \(error.userInfo)");
        }
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
