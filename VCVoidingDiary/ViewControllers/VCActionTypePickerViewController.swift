//
//  VCActionTypePickerViewController.swift
//  VCVoidingDiary
//
//  Created by victor on 16/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit

class VCActionTypePickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if appDelegate.managedObjectInEdit != nil {
            self.title = "修改(紀錄項目)"
        } else {
            self.title = "紀錄項目"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
