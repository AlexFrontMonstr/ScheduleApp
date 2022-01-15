//
//  ClientsViewController.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 13.12.2021.
//

import UIKit
import RealmSwift

class ClientsTableViewController: UITableViewController {

    private let localRealm = try! Realm()
    private var contactArray: Results<ContactModel>!
    private let clientsId = "clientsId"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "clients"
        view.backgroundColor = .white
        
        contactArray = localRealm.objects(ContactModel.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: clientsId)
    }
    
    //MARK:UITableViewDelegate, UITableViewDataSource
    
    private func setClients( clients: String){
        let scheduleOptions = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
        scheduleOptions?.scheduleModel.scheduleClient = clients
        scheduleOptions?.cellNameArray[1][0] = clients
        scheduleOptions?.tableView.reloadRows(at: [[1,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: clientsId, for: indexPath) as! ContactsTableViewCell
        let model = contactArray[indexPath.row]
        cell.configure(model:model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactArray[indexPath.row]
        setClients(clients: model.contactName)
    }
}


