//
//  AlertDate.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 12.12.2021.
//

import UIKit

extension UIViewController {
    
    func alertDate(label:UILabel,completionHandler: @escaping (Int, Date) -> Void) {
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        alert.view.addSubview(datePicker)
        
        let okey = UIAlertAction(title: "Ok", style: .default) { (action) in
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormater.string(from: datePicker.date)
            
            let calendar = Calendar.current
            let component = calendar.dateComponents([.weekday], from: datePicker.date)
            guard let weekday = component.weekday else {return}
            let numberOfWeekday = weekday
            let date = datePicker.date 
            completionHandler(numberOfWeekday, date)
            
            label.text = dateString
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(okey)
        alert.addAction(cancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
