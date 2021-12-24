//
//  ContactsTableViewCell.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 17.12.2021.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    let contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ironman")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let phoneImageView: UIImageView = {
        let phoneImage = UIImageView()
        phoneImage.image = UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysTemplate)
        phoneImage.tintColor = .green
        phoneImage.translatesAutoresizingMaskIntoConstraints = false
        return phoneImage
    }()
    
    let instaImageView: UIImageView = {
        let instaImage = UIImageView()
        instaImage.image = UIImage(systemName: "paperplane.circle.fill")?.withRenderingMode(.alwaysTemplate)
        instaImage.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        instaImage.translatesAutoresizingMaskIntoConstraints = false
        return instaImage
    }()
    
    let nameLabel = UILabel(text: "Tony Stark", font: UIFont(name: "Avenir Next Demi", size: 20), textAligment: .natural)
    let phoneLabel = UILabel(text: "8 929 811 9999", font: UIFont(name: "Avenir Next Demi", size: 14), textAligment: .left)
    let instaLabel = UILabel(text: "ironMan163", font: UIFont(name: "Avenir Next Demi", size: 14), textAligment:.natural)
    
    override func layoutIfNeeded() {
        super.layoutSubviews()
        
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraits()
        
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraits() {
        
        self.addSubview(contactImageView)
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contactImageView.widthAnchor.constraint(equalToConstant: 70),
            contactImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [phoneImageView,phoneLabel,instaImageView,instaLabel], axis: .horizontal, spacing: 3, distribution:  .fillProportionally)
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
}

