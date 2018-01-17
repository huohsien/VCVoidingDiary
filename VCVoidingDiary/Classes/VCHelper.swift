//
//  VCHelper.swift
//  VCVoidingDiary
//
//  Created by victor on 12/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit

class VCHelper {
    
//    static func getCurrentTimeInFourDigitsInteger() -> Int {
//        
//        let date = Date()
//        let calender = Calendar.current
//        let hour = calender.component(.hour, from: date)
//        let min = calender.component(.minute, from: date)
//        return (hour * 100 + min)
//    }
    
    static func showAlert(title: String, message: String, completion: @escaping (_ isCancelled: Bool) -> Void) {
        
//        for name in UIFont.familyNames {
//                print(UIFont.fontNames(forFamilyName:name))
//        }
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let attributedTitleString = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "cwTeXFangSong", size: 26.0) as Any])
        alertController.setValue(attributedTitleString, forKey: "attributedTitle")
        
        let cancelAction = UIAlertAction.init(title: "否", style: .cancel, handler: { action in
            completion(true)
        })
        
        let ok = UIAlertAction.init(title: "是", style: .default, handler: { action in
            completion(false)
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


