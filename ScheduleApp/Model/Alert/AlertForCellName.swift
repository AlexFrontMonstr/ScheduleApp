//
//  AlertForCellName.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 13.12.2021.
//

import UIKit

extension UIViewController {
    
    func alertForCellName (label:UILabel, name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let okey = UIAlertAction(title: "Ok", style: .default) { (action) in
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text else {return}
            label.text = text
            completionHandler(text)
        }
        
        alert.addTextField { (tfAlert) in
            tfAlert.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(okey)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
