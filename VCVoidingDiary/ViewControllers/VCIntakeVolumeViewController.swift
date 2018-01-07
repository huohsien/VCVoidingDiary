//
//  VCIntakeVolumeViewController.swift
//  VCVoidingDiary
//
//  Created by victor on 07/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit

class VCIntakeVolumeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {

        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0);

        for subview in (self.navigationController?.navigationBar.subviews)! {
            print(NSStringFromClass(subview.classForCoder));
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
