//
//  AlertSavedSucces.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 27.12.2021.
//

import UIKit

extension UIViewController {
    
    func alertSavedSuccess (title:String, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okey = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okey)
        
        present(alert, animated: true, completion: nil)
    }
}
