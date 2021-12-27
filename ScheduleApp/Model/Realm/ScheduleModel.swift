//
//  ScheduleModel.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 23.12.2021.
//

import RealmSwift
import Foundation

class ScheduleModel: Object {
    @Persisted var scheduleDate = Date()
    @Persisted var scheduleTime = Date()
    @Persisted var scheduleClient: String = "Name LastName"
    @Persisted var scheduleName: String = ""
    @Persisted var scheduleType: String = ""
    @Persisted var scheduleDuration: String = ""
    @Persisted var schedulePrice: String = ""
    @Persisted var scheduleColor: String = "3DACF7"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
 
}
