//
//  VCVoidingVolumeViewController.swift
//  VCVoidingDiary
//
//  Created by victor on 09/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit
import CocoaLumberjack

class VCVoidingVolumeViewController: UIViewController {

    var volume : Int = 0
    private var digitPlace : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        space = 12.0;
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
            addNewRecord();
            
            let navigationController = self.presentingViewController as? UINavigationController;
            dismiss(animated: false, completion: {
                navigationController?.popToRootViewController(animated: true);
            })
        }
    }
    
    func addNewRecord() {
        
        DDLogDebug("add a new record")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let record = Record(day: 1, time: getCurrentTimeInFourDigitsInteger(), voidingVolume: volume, intakeVolume: 0, isNightTime: appDelegate.isNightTime);
        if  record == nil {
            DDLogError("fail to create a valid record")
        } else {
        }
    }
    
    func getCurrentTimeInFourDigitsInteger() -> Int {
        
        let date = Date()
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date)
        let min = calender.component(.minute, from: date)
        return (hour * 100 + min)
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
