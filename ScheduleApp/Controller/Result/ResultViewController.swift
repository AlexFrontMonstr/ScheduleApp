//
//  TasksViewController.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 01.12.2021.
//

import UIKit
import FSCalendar
import RealmSwift

class ResultViewController: UIViewController {
    
    private var calendarHeightConstrait: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
        
    }()
    //MARK: Create the button open calendar
    
    private let showHiddenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let isTasksCell = "isTasksCell"
    
    let localRealm = try! Realm()
    var resultArray: Results<ResultModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Result"
        
        setConstraints()
        swipeAction()
        setArray()
        
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.scope = .week
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: isTasksCell)
        
        showHiddenButton.addTarget(self, action: #selector (showHiddenButtonTaped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTaped))
    }
    
    
    @objc private func addButtonTaped(){
        let resultOption = ResultOptionsTableViewController()
        navigationController?.pushViewController(resultOption, animated: true)
        
    }
    
    @objc private func showHiddenButtonTaped() {
        
        if calendar.scope == .week{
            calendar.setScope(.month, animated: true)
            showHiddenButton.setTitle("Close calendar", for: .normal )
        }else {
            calendar.setScope(.week, animated: true)
            showHiddenButton.setTitle("Open calendar", for: .normal )
        }
    }
    
    func setArray() {
    resultArray = localRealm.objects(ResultModel.self).sorted(byKeyPath: "resultDate")
    tableView.reloadData()
    }
    
    //MARK:SwapeGestureRecognizer
    
    private func  swipeAction() {
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
        
    }
    
    @objc private func handleSwipe(gesture:UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up:
            showHiddenButtonTaped()
        case .down:
            showHiddenButtonTaped()
        default:
            break
        }
    }
}
//MARK:UITableViewDelegate, UITableViewDataSource

extension  ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: isTasksCell, for: indexPath) as! ResultTableViewCell
        let model = resultArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: FSCalendarDataSource, FSCalendarDelegate

extension ResultViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstrait.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = resultArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteResultModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: SetConstraints

extension ResultViewController {
    
    func setConstraints(){
        
        view.addSubview(calendar)
        
        calendarHeightConstrait = NSLayoutConstraint.init(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstrait)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
        ])
        
        view.addSubview(showHiddenButton)
        
        NSLayoutConstraint.activate([
            showHiddenButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHiddenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHiddenButton.widthAnchor.constraint(equalToConstant: 100),
            showHiddenButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate ([
            tableView.topAnchor.constraint(equalTo: showHiddenButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}


