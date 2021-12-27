//
//  ScheduleColorViewController.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 13.12.2021.
//

import UIKit

class ScheduleColorsViewController: UITableViewController{
    
    private let isOptionsColorCell = "isOptionsColorCell"
    private let isOptionColorHeader = "isOptionColorHeader"
    
    let headerNamesArray = ["GREEN","YELLOW","RED","BLUE","DEEP BLUE","PINK","PURPLE",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ColorsScheduleTableViewCell.self, forCellReuseIdentifier: isOptionsColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: isOptionColorHeader)
        
        title = "Colors Schedule"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: isOptionsColorCell, for: indexPath) as! ColorsScheduleTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: isOptionColorHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNamesArray,section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: SetColor(color: "579F2B")
        case 1: SetColor(color: "F9D98C")
        case 2: SetColor(color: "CE0755")
        case 3: SetColor(color: "3DACF7")
        case 4: SetColor(color: "3802DA")
        case 5: SetColor(color: "FF54FF")
        case 6: SetColor(color: "8E5AF7")
        default:
            SetColor(color: "FFFFFF")
        }
    }
    
    private func SetColor(color:String) {
        let scheduleOptions = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
        scheduleOptions?.hexColorCell = color
        scheduleOptions?.tableView.reloadRows(at: [[3,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
        
    }
}



