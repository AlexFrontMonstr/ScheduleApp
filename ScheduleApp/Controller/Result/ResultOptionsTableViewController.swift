//
//  TasksOptionTableView.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 14.12.2021.
//


import UIKit

class ResultOptionsTableViewController: UITableViewController {
    
    private let isOptionsTaskCell = "isOptionsTaskCell"
    private let isOptionsTaskHeader = "isOptionsTaskHeader"
    
    let headerNamesArray = ["DATE","CLIENT COUNT","PROFIT"]
    
    let cellNameArray = ["Date","Number","Total"]
    
    var resultModel = ResultModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: isOptionsTaskCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: isOptionsTaskHeader)
        
        title = "Option Result"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveResultButtonTapped))
    }
    
    @objc private func saveResultButtonTapped(){
                RealmManager.shared.SaveResultModel(model: resultModel)
                resultModel = ResultModel()
                alertSavedSuccess(title: "Success", message: nil)
                tableView.reloadData()
            }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: isOptionsTaskCell, for: indexPath) as! OptionsTableViewCell
        cell.cellResultConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: isOptionsTaskHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNamesArray,section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section{
        
        case 0: alertTaskDate(label: cell.nameCellLabel) { (date)  in
            self.resultModel.resultDate = date
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Number of clients", placeholder: "Enter number") {text in
            self.resultModel.resultClientCount = text
        }
            
        case 2:  alertForCellName(label: cell.nameCellLabel, name: "Profit", placeholder: "Enter progit margin") {text in
            self.resultModel.resultProfit = text
            }
        default:
            print("Tap OptionsTableView")
        }
    }
}
