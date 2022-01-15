//
//  ContactOptionTableViewController.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 20.12.2021.
//

import UIKit
import RealmSwift

class ContactsOptionsTableViewController: UITableViewController{
    
    private let isContactOptions = "isContactOptions"
    private let isContactHeader = "isContactHeader"
    
    let headerNamesArray = ["CLIENT","PHONE","INSTAGRAM","TYPE","CHOOSE IMAGE"]
    var cellNameArray = ["Client Name", "Phone Number", "Instagram","Type",""]
    
    
     var imageIsChanged = false
    var contactModel = ContactModel()
    var editModel = false
    var dataImagePhoto:Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: isContactOptions)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: isContactHeader)
        
        title = "Option Contacts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContactButtonTapped))
    }
    
    @objc private func saveContactButtonTapped(){
        
        if cellNameArray[0] == "Client Name" || cellNameArray[1] == "Phone Number" {
            alertSavedSuccess(title: "NOTE", message: "Required to fill: CLIENT,PHONE")
        } else if editModel == false {
            setImageModel()
            setModel()
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            
            cellNameArray = ["Client Name", "Phone Number", "Instagram","Type",""]
            alertSavedSuccess(title: "Success", message: nil)
            tableView.reloadData()
        }else{
            setImageModel()
            RealmManager.shared.updateContactModel(model: contactModel, nameArray: cellNameArray, imageData: dataImagePhoto)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setModel() {
        contactModel.contactName = cellNameArray[0]
        contactModel.contactPhone = cellNameArray[1]
        contactModel.contactInsta = cellNameArray[2]
        contactModel.contactType = cellNameArray[3]
        contactModel.contactPhoto = dataImagePhoto
    }
    
    @objc private func setImageModel(){
        
        if imageIsChanged{
            let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
            
            let image = cell.backgroundViewCell.image
            guard let imageData = image?.pngData() else {return}
            dataImagePhoto = imageData
            
            cell.backgroundViewCell.contentMode = .scaleAspectFit
            imageIsChanged = false
        } else {
            dataImagePhoto = nil
        }
    }
    
    //MARK:UITableViewDelegate, UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: isContactOptions, for: indexPath) as! OptionsTableViewCell
        
        // the sick way to make to do within "editing photo", but i just tryed to find out something like that
        if editModel == false {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        } else if let data = contactModel.contactPhoto, let photo = UIImage(data: data){
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image:photo )
        } else {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }
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
        case 0 : alertForCellName(label: cell.nameCellLabel, name: "Name contact", placeholder: "Enter name contact") {text in
            //            self.contactModel.contactName = text
            self.cellNameArray[0] = text
        }
        case 1 : alertForCellName(label: cell.nameCellLabel, name: "Phone contact", placeholder: "Enter phone contact") {text in
            //            self.contactModel.contactPhone = text
            self.cellNameArray[1] = text
        }
        case 2 : alertForCellName(label: cell.nameCellLabel, name: "Instagram contact", placeholder: "Enter instagram contact") {text in
            //            self.contactModel.contactInsta = text
            self.cellNameArray[2] = text
        }
        case 3 : alertContact(label: cell.nameCellLabel) { (type) in
            //            self.contactModel.contactType = type
            self.cellNameArray[3] = type
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
        imageIsChanged = true
        dismiss(animated: true)
    }
}
