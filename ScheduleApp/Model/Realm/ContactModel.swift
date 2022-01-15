//
//  ContactModel.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 06.01.2022.
//

import Foundation
import RealmSwift

class ContactModel: Object {
    @Persisted var contactName: String = ""
    @Persisted var contactPhone: String = ""
    @Persisted var contactInsta: String = ""
    @Persisted var contactType: String = ""
    @Persisted var contactPhoto: Data?
}
