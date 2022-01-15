//
//  ResultModel.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 05.01.2022.
//

import RealmSwift
import Foundation


class ResultModel: Object {
    @Persisted var resultDate: Date?
    @Persisted var resultClientCount: String = ""
    @Persisted var resultProfit: String = ""
}
