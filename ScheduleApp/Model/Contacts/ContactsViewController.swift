 //
 //  ContactsTableViewController.swift
 //  ScheduleApp
 //
 //  Created by Александр Полетаев on 17.12.2021.
 //
 
 import UIKit
 import  RealmSwift
 
 class ContactsViewController: UIViewController {
    
    let searchController = UISearchController()
    
    var isFiltering: Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private let isContactsCell = "isContactsCell"
    
    let localRealm = try! Realm()
    var contactArray: Results<ContactModel>!
    var filtredArray: Results<ContactModel>! // for searchingbar
    var searchBarIsEmpty: Bool{
        guard let text = searchController.searchBar.text else {return true}
        return text.isEmpty
    }
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Clients", "My friends clients"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
   private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraits()
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        contactArray = localRealm.objects(ContactModel.self).filter("contactType = 'My Clients'")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: isContactsCell)
        
        title = "Contact"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addcontacttapped))
        
        segmentedControl.addTarget(self, action: #selector (segmentChanged), for: .valueChanged)
        
    }
    
    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            contactArray = localRealm.objects(ContactModel.self).filter("contactType = 'My Clients'")
            tableView.reloadData()
        }else {
            contactArray = localRealm.objects(ContactModel.self).filter("contactType = 'My Friends Clients'")
            tableView.reloadData()
        }
    }
    
    @objc func addcontacttapped() {
        let contactOption = ContactsOptionsTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
    }
    
    @objc func editingModel(contactModel:ContactModel) {
        let contactOption = ContactsOptionsTableViewController()
        contactOption.contactModel = contactModel
        contactOption.editModel = true
        contactOption.cellNameArray = [contactModel.contactName,
                                       contactModel.contactPhone,
                                       contactModel.contactInsta,
                                       contactModel.contactType,
                                       ""]
        contactOption.imageIsChanged = true
        navigationController?.pushViewController(contactOption, animated: true)
    }
 }
    
 //MARK:UITableViewDelegate, UITableViewDataSource
 
 extension ContactsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ( isFiltering ? filtredArray.count :contactArray.count )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: isContactsCell, for: indexPath) as! ContactsTableViewCell
        let model = (isFiltering ? filtredArray[indexPath.row] : contactArray[indexPath.row])
        cell.configure(model:model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactArray[indexPath.row]
        editingModel(contactModel: model)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = contactArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
 }
 
 extension ContactsViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filtrContactForSearchText(searchController.searchBar.text!)
    }
    private func filtrContactForSearchText(_ searchText:String){
        filtredArray = contactArray.filter("contactName CONTAINS[c] %@", searchText)
        tableView.reloadData()
    }
 }
 
 // MARK:Constraint for SegmentedCOntrol
 extension ContactsViewController{
    
    private func setConstraits(){
        
        let stackView = UIStackView(arrangedSubviews: [segmentedControl,tableView], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
 }
