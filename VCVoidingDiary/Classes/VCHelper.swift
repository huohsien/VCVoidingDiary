//
//  VCHelper.swift
//  VCVoidingDiary
//
//  Created by victor on 12/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit

class VCHelper {
    static func getCurrentTimeInFourDigitsInteger() -> Int {
        
        let date = Date()
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date)
        let min = calender.component(.minute, from: date)
        return (hour * 100 + min)
    }
}

extension UIViewController {
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
