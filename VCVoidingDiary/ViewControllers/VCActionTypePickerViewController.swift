//
//  VCActionTypePickerViewController.swift
//  VCVoidingDiary
//
//  Created by victor on 16/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit
import CocoaLumberjack

class VCActionTypePickerViewController: UIViewController {

    //MARK:- Variables
    @IBOutlet weak var intakeButton: DesignableButton!
    @IBOutlet weak var voidingButton: DesignableButton!
    
    //MARK:- Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        intakeButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        intakeButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        intakeButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
        voidingButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        voidingButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        voidingButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if appDelegate.managedObjectInEdit != nil {
            self.title = "修改(紀錄項目)"
            
            let record : Record = appDelegate.managedObjectInEdit as! Record
            if record.intakeVolume > 0 {
                
                self.intakeButton.borderWidth = VCConstants.borderWidthButton
                
            } else if record.voidingVolume > 0 {
                
                self.voidingButton.borderWidth = VCConstants.borderWidthButton

            } else {
                DDLogError("should never be here!")
            }
            
        } else {
            self.title = "紀錄項目"
        }
       
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.intakeButton.borderWidth = 0.0
        self.voidingButton.borderWidth = 0.0
        
    }

    //MARK: - button handlers
    
    
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
    }
    
}
