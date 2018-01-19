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
        
        dayButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        dayButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        dayButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
        nightButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        nightButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        nightButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if appDelegate.managedObjectInEdit != nil {
            self.title = "修改(時段)"
            
            let record : Record = appDelegate.managedObjectInEdit as! Record
            if record.isNightTime {
                
                self.nightButton.borderWidth = VCConstants.borderWidthButton
                
            } else {
                
                self.dayButton.borderWidth = VCConstants.borderWidthButton

            }
        
        } else {
            self.title = "時段"
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.nightButton.borderWidth = 0.0
        self.dayButton.borderWidth = 0.0

    }
    

    //MARK: - button handlers
    
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        DDLogDebug("menu button is pressed");
        
    }
    
    
    @objc func buttonTouchDown(button : UIButton) {
        button.alpha = VCConstants.alphaButtonTouchDown
        button.shadowOpacity = 1.0
        button.borderWidth = VCConstants.borderWidthButton
    }
    @objc func buttonTouchUp(button : UIButton) {
        button.alpha = VCConstants.alphaButtonNormal
        button.shadowOpacity = 0.0
        button.borderWidth = 0.0
        
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
        } else if segue.identifier == "showRecordReportView" {
            DDLogDebug("perform segue of showRecordReportView")
        }
    }


}
