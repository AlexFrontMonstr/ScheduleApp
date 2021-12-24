//
//  AlertContact.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 20.12.2021.
//

import UIKit

extension UIViewController {
    
    func  alertContact(label: UILabel, completionHandle: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let myClients = UIAlertAction(title: "My Clients", style: .default) { _ in
            label.text = "My Clients"
            let typeContact = "My Clients"
            completionHandle(typeContact)
        }
        
        let myFriendsClients = UIAlertAction(title: "My Friends Clients", style: .default) { _ in
            label.text = "My Friends Clients"
            let typeContact = "My Friends Clients"
            completionHandle(typeContact)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(myClients)
        alertController.addAction(myFriendsClients)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
}
