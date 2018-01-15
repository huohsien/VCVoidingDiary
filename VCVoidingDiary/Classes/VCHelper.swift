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
    static func showAlert(title: String, message: String) {
        
//        for name in UIFont.familyNames {
//                print(UIFont.fontNames(forFamilyName:name))
//        }
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let attributedTitleString = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "cwTeXKai", size: 26.0)])
        alertController.setValue(attributedTitleString, forKey: "attributedTitle")
        
        let cancelAction = UIAlertAction.init(title: "不用", style: .cancel, handler: { action in
            print(action)
        })
        
        let ok = UIAlertAction.init(title: "好", style: .default, handler: { action in
            print(action)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(ok)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)

    }
}

extension UIViewController {
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
