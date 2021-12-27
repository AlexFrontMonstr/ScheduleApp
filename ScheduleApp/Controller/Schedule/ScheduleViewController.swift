//
//  File.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 01.12.2021.
//

import UIKit
import FSCalendar
import RealmSwift

class ScheduleViewController: UIViewController {
    
    private let isScheduleCell = "isScheduleCell"
    
    private var calendarHeightConstrait: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
        
    }()
    
    //MARK: Create the button open calendar
    
    private let showHideButton: UIButton = {
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
    
    let localRealm = try! Realm()
    var scheduleArray: Results<ScheduleModel>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Schedule"
    
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.scope = .week
        
        showHideButton.addTarget(self, action: #selector (showHiddenButtonTaped), for: .touchUpInside)
        
        setConstraints()
        ScheduleOnDay(date: Date())
        swipeAction()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: isScheduleCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func addButtonTapped(){
        let scheduleOption = ScheduleOptionsTableViewController()
        navigationController?.pushViewController(scheduleOption, animated: true)
        
    }
    
    @objc private func showHiddenButtonTaped() {
        
        if calendar.scope == .week{
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal )
        }else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open calendar", for: .normal )
        }
    }
    
    //MARK:SwapeGestureRecognizer
    
    private func swipeAction(){
        
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
    
    private func ScheduleOnDay(date:Date){
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else {return}
        
        let dataStart = date
        let dataEnd: Date = {
            let component = DateComponents(day:1, second: -1)
            return Calendar.current.date(byAdding: components, to: dataStart)!
        }()
        
        let predicateRepeat = NSPredicate(format: "scheduleWeekday = \(weekday) AND scheduleRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "scheduleRepeat = false AND scheduleDate BETWEEN %@", [dataStart,dataEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat,predicateUnrepeat])
        
        scheduleArray = localRealm.objects(ScheduleModel.self).filter(compound).sorted(byKeyPath: "scheduleTime")
        tableView.reloadData()
    }
}

//MARK:UITableViewDelegate, UITableViewDataSource

extension  ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: isScheduleCell, for: indexPath) as! ScheduleTableViewCell
        let model = scheduleArray[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
}

//MARK: FSCalendarDataSource, FSCalendarDelegate

extension ScheduleViewController: FSCalendarDataSource, FSCalendarDelegate{
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstrait.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        ScheduleOnDay(date: date)
    }
}

//MARK: SetConstraints

extension ScheduleViewController {
    
    func setConstraints(){
        
        view.addSubview(calendar)
        calendarHeightConstrait = NSLayoutConstraint.init(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstrait)
        
        NSLayoutConstraint.activate ([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        view.addSubview(showHideButton)
        NSLayoutConstraint.activate ([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.widthAnchor.constraint(equalToConstant: 100),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate ([
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

