//
//  OptionsSchedualeViewController.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 08.12.2021.
//

import UIKit

class OptionsScheduleTableViewController: UITableViewController{
    
    let isOptions = "isOptions"
    let isOptionsHeader = "isOptionsHeader"
    let headerNamesArray = ["DATE AND TIME","CLIENT","SERVICE","COLOR","PERIOD"]
    let cellNameArray = [["Date ","Time"],["Client Name"],["Name","Type","Duration","Price"],[""],["Repeat every 7 days"]]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: isOptions)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: isOptionsHeader)
        
        title = "Optional Schedule"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return 4
        case 3: return 1
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: isOptions, for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: isOptionsHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNamesArray,section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath {
        case [0,0]: alertDate(label: cell.nameCellLabel) { (numberOfWeekday, date )
            in
            print(numberOfWeekday,date)
        }
        case [0,1]: alertTime(label: cell.nameCellLabel) { (date) in
            print(date)
        }
        case [2,0]: alertForCellName(label: cell.nameCellLabel, name: "Service Name", placeholder: "Enter service name")
        case [2,1]:  alertForCellName(label: cell.nameCellLabel, name: "DesignType", placeholder: "Enter design type")
        case [2,2]: alertForCellName(label: cell.nameCellLabel, name: "Service duration", placeholder: "Enter service duration")
        case [2,3]: alertForCellName(label: cell.nameCellLabel, name: "Service Price", placeholder: "Enter  service price")
            
        case [1,0]:
            let clients = ClientsViewController()
            navigationController?.navigationBar.topItem?.title = "Options"
            navigationController?.pushViewController(clients, animated: true)
            
        case [3,0]:
            let colors = ScheduleColorViewController()
            navigationController?.navigationBar.topItem?.title = "Options"
            navigationController?.pushViewController(colors, animated: true)
        default:
            print("Tap OptionsTableView")
        }
    }
}
