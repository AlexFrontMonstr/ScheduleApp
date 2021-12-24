//
//  RealmManager.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 23.12.2021.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveScheduleModel(model: ScheduleModel){
        try! localRealm.write {
            localRealm.add(model)
        }
    }
}
