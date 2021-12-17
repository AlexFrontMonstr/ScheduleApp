//
//  TasksTableViewCell.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 07.12.2021.
//

import UIKit


class TasksTableViewCell: UITableViewCell {
    
    let noteName = UILabel(text: "Описание заметки", font: UIFont( name: "Avenir Next Demi Bold", size: 18), textAligment: .left)
    let noteDiscription = UILabel(text: "Текст заметки", font: UIFont(name: "Avenir Next", size: 14), textAligment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraits()
        
        self.selectionStyle = .none
        noteDiscription.numberOfLines = 0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraits() {
        
        self.addSubview(noteName)
        NSLayoutConstraint.activate([
            noteName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            noteName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            noteName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            noteName.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(noteDiscription )
        NSLayoutConstraint.activate([
            noteDiscription.topAnchor.constraint(equalTo: noteName.bottomAnchor, constant: 5),
            noteDiscription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            noteDiscription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            noteDiscription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
