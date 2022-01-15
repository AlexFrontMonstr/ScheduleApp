//
//  TasksTableViewCell.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 07.12.2021.
//

import UIKit


class ResultTableViewCell: UITableViewCell {
    
    let datePeriod = UILabel(text: "Period:", font: UIFont( name: "Avenir Next", size: 18), textAligment: .left)
    let datelabel = UILabel(text: "", font: UIFont( name: "Avenir Next Demi Bold", size: 18), textAligment: .left)
    
    let numberOfClients = UILabel(text: "Number of clients:", font: UIFont(name: "Avenir Next", size: 14), textAligment: .left)
    let numberLabel = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), textAligment: .left)
    
    let profitForMonth = UILabel(text: "Profit:", font: UIFont(name: "Avenir Next", size: 14), textAligment: .right)
    let profitLabel = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), textAligment: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraits()
        
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model:ResultModel){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        guard let date = model.resultDate else {return}
        datelabel.text = dateFormatter.string(from: date)
        numberLabel.text = model.resultClientCount
        profitLabel.text = model.resultProfit
    }
    
    func setConstraits() {
        
        let dateStackView = UIStackView(arrangedSubviews: [datePeriod,datelabel], axis: .horizontal, spacing: 5, distribution: .fillProportionally)
        
        self.addSubview(dateStackView)
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            dateStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
//            dateStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            dateStackView.heightAnchor.constraint(equalToConstant: 25)
        ])

        let numberStackView = UIStackView(arrangedSubviews: [numberOfClients,numberLabel], axis: .horizontal, spacing: 5, distribution: .fillEqually)
        
        self.addSubview(numberStackView )
        NSLayoutConstraint.activate([
            numberStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 5),
            numberStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
//            numberStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            numberStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        let profitStackView = UIStackView(arrangedSubviews: [profitForMonth,profitLabel], axis: .horizontal, spacing: 5, distribution: .fillEqually)
        
        self.addSubview(profitStackView )
        NSLayoutConstraint.activate([
            profitStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 5),
            profitStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            profitStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
