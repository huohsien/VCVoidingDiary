//
//  VCDayNightPickerViewController.swift
//  VCVoidingDiary
//
//  Created by victor on 07/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit
import CocoaLumberjack

class VCDayNightPickerViewController: UIViewController {

    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var nightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if appDelegate.managedObjectInEdit != nil {
            self.title = "修改(時段)"
        } else {
            self.title = "時段"
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        DDLogDebug("menu button is pressed");
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let button = sender as? UIButton {

            let dayOrNightString = (button.titleLabel?.text)!
            DDLogDebug("dayOrNightString = \(dayOrNightString)")
            if dayOrNightString == "白天" {
                appDelegate.isNightTime = false;
                DDLogDebug("isNightTime is set to be false");
            } else {
                appDelegate.isNightTime = true;
                DDLogDebug("isNightTime is set to be true");
            }
        } else if let barButton = sender as? UIBarButtonItem {
            DDLogDebug("go to record report view")
        }

        
    }

}
