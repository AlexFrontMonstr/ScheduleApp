//
//  RealmManager.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 23.12.2021.
//

import RealmSwift
import UIKit

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    //MARK: Schedule
    func saveScheduleModel(model: ScheduleModel){
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteScheduleModel(model: ScheduleModel){
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    //MARK: Result
    func SaveResultModel(model: ResultModel){
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteResultModel(model: ResultModel){
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    //MARK: Contact
    
    func saveContactModel(model: ContactModel){
        try! localRealm.write {
            localRealm.add(model)
        }
    }

    func deleteContactModel(model: ContactModel){
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateContactModel(model: ContactModel,nameArray:[String],imageData: Data?){
        try! localRealm.write {
            model.contactName = nameArray[0]
            model.contactPhone = nameArray[1]
            model.contactInsta = nameArray[2]
            model.contactType = nameArray[3]
            model.contactPhoto = imageData
        }
    }
}



