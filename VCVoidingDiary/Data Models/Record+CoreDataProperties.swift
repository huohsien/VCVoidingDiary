//
//  Record+CoreDataProperties.swift
//  VCVoidingDiary
//
//  Created by victor on 12/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var time: Int16
    @NSManaged public var day: Int16
    @NSManaged public var intakeVolume: Int16
    @NSManaged public var voidingVolume: Int16
    @NSManaged public var isNightTime: Bool

}
