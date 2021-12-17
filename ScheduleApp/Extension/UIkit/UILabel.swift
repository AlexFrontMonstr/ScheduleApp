//
//  UILabel.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 07.12.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, textAligment: NSTextAlignment) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = .black
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
