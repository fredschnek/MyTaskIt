//
//  TaskModel.swift
//  MyTaskIt
//
//  Created by Frederico Schnekenberg on 25/05/15.
//  Copyright (c) 2015 MisfitRebels. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var task: String
    @NSManaged var subTask: String
    @NSManaged var date: NSDate
    @NSManaged var isCompleted: NSNumber

}