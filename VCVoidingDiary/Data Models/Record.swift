//
//  Record.swift
//  VCVoidingDiary
//
//  Created by victor on 11/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import Foundation
import CocoaLumberjack

//class Record {
//    //MARK: Properties
//    
//    var day : Int
//    var time : Int
//    var voidingVolume : Int
//    var intakeVolume : Int
//    var isNightTime : Bool
//    
//    //MARK: Initialization
//    
//    init?(day: Int, time: Int, voidingVolume : Int, intakeVolume : Int, isNightTime : Bool) {
//     
//        self.day = day;
//        self.time = time;
//        self.voidingVolume = voidingVolume;
//        self.intakeVolume = intakeVolume;
//        self.isNightTime = isNightTime;
//        
//        if day <= 0 || time < 0 || voidingVolume < 0 || intakeVolume < 0 || !checkTimeValidity() {
//            return nil;
//        }
//        DDLogDebug("isNightTime = \(isNightTime)")
//    }
//    
//    func checkTimeValidity() -> Bool {
//        let hour = time / 100;
//        DDLogDebug("hour = \(hour)");
//        if hour < 0 || hour > 24 {
//            return false;
//        }
//        let minute = time % 100;
//        DDLogDebug("minute = \(minute)");
//        if minute < 0 || minute > 59 {
//            return false;
//        }
//        return true;
//    }
//}

