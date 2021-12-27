//
//  ScheduleTableViewCell.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 05.12.2021.
//

import UIKit


class ScheduleTableViewCell: UITableViewCell {
    
    let serviceType = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 18), textAligment: .left)
    
    let clientName = UILabel(text: "", font: UIFont(name: "Avenir Next", size: 18), textAligment: .right)
    
    let serviceTime = UILabel (text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 18), textAligment: .left)
    
    let typeOfDesign = UILabel(text: "Type:", font: UIFont(name: "Avenir Next", size: 14), textAligment: .right)
    
    let designLabel = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), textAligment: .left)
    
    let serviceDuration = UILabel(text: "Duration:", font: UIFont(name: "Avenir Next", size: 14), textAligment: .right)
    
    let durationLabel = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), textAligment: .left)
    
    let servicePrice = UILabel(text: "Price:", font: UIFont(name: "Avenir Next", size: 14), textAligment: .right)
    
    let priceLabel = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), textAligment: .left)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraits()
        
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model:ScheduleModel){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        serviceType.text = model.scheduleName
        clientName.text = model.scheduleClient
        serviceTime.text = dateFormatter.string(from: model.scheduleTime)
        designLabel.text = model.scheduleType
        durationLabel.text = model.scheduleDuration
        priceLabel.text = model.schedulePrice
        backgroundColor = UIColor().colorFromHex("\(model.scheduleColor)")
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
