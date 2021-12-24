 //
 //  ContactsTableViewController.swift
 //  ScheduleApp
 //
 //  Created by Александр Полетаев on 17.12.2021.
 //
 
 import UIKit
 
 class ContactsTableViewController: UITableViewController {
    
    let searchController = UISearchController()
    
    private let isContactsCell = "isContactsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: isContactsCell)
        
        title = "Contacts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addcontacttapped))
        
    }
    
    @objc func addcontacttapped(){
        let contactOption = ContactsOptionsTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: isContactsCell, for: indexPath) as! ContactsTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("tapcell")
    }
 }
 
