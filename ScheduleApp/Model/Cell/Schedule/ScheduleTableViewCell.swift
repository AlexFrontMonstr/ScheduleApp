//
//  ScheduleTableViewCell.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 05.12.2021.
//

import UIKit


class ScheduleTableViewCell: UITableViewCell {
    
    let serviceType = UILabel(text: "Маникюр", font: UIFont(name: "Avenir Next Demi Bold", size: 18), textAligment: .left)
    
    let clientName = UILabel(text: "Лена Бомбарова", font: UIFont(name: "Avenir Next", size: 18), textAligment: .right)
    
    let serviceTime = UILabel (text: "15:00", font: UIFont(name: "Avenir Next Demi Bold", size: 18), textAligment: .left)
    
    let typeOfDesign = UILabel(text: "Type:", font: UIFont(name: "Avenir Next", size: 14), textAligment: .right)
    
    let designLabel = UILabel(text: "Гель лак", font: UIFont(name: "Avenir Next Demi Bold", size: 14), textAligment: .left)
    
    let serviceDuration = UILabel(text: "Duration:", font: UIFont(name: "Avenir Next", size: 14), textAligment: .right)
    
    let durationLabel = UILabel(text: "1.5", font: UIFont(name: "Avenir Next Demi Bold", size: 14), textAligment: .left)
    
    let servicePrice = UILabel(text: "Price:", font: UIFont(name: "Avenir Next", size: 14), textAligment: .right)
    
    let priceLabel = UILabel(text: "1200", font: UIFont(name: "Avenir Next Demi Bold", size: 14), textAligment: .left)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraits()
        
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraits() {
        
        let topStackView = UIStackView(arrangedSubviews: [serviceType,clientName], axis: .horizontal, spacing: 10, distribution: .fill)
        
        self.addSubview(topStackView)
        NSLayoutConstraint.activate ([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
            
        ])
        
        self.addSubview(serviceTime)
        NSLayoutConstraint.activate ([
            serviceTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            serviceTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            serviceTime.widthAnchor.constraint(equalToConstant: 100),
            serviceTime.heightAnchor.constraint(equalToConstant: 25)
            
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [typeOfDesign,designLabel,serviceDuration,durationLabel,servicePrice,priceLabel], axis: .horizontal, spacing: 8, distribution: .fillProportionally)
        
        self.addSubview(bottomStackView)
        NSLayoutConstraint.activate ([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
}
