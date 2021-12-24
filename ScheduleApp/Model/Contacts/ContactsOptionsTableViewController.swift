//
//  ContactOptionTableViewController.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 20.12.2021.
//

import UIKit

class ContactsOptionsTableViewController: UITableViewController{
    
    private let isContactOptions = "isContactOptions"
    private let isContactHeader = "isContactHeader"
    
    let headerNamesArray = ["PHONE","PHONE","INSTAGRAM","TYPE","CHOOSE IMAGE"]
    let cellNameArray = ["Client Name", "Phone Number", "Instagram","Type",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: isContactOptions)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: isContactHeader)
        
        title = "Contacts"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: isContactOptions, for: indexPath) as! OptionsTableViewCell
        cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: isContactHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNamesArray,section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0 : alertForCellName(label: cell.nameCellLabel, name: "Name contact", placeholder: "Enter name contact") {text in print("text")}
        case 1 : alertForCellName(label: cell.nameCellLabel, name: "Phone contact", placeholder: "Enter phone contact") {text in print("text")}
        case 2 : alertForCellName(label: cell.nameCellLabel, name: "Instagram contact", placeholder: "Enter instagram contact") {text in print("text")}
        case 3 : alertContact(label: cell.nameCellLabel) { (type) in
            print(type)
        }
        case 4 : alertPhotoOrCamera { [self] sourse in
            chooseImagePicker(sourse: sourse)
        }
        default :
            print("Tap ContactsTableView")
            
        }
    }
}

extension ContactsOptionsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(sourse: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker,animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
        
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        dismiss(animated: true)
    }
}
