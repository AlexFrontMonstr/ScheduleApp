//
//  File.swift
//  ScheduleApp
//
//  Created by Александр Полетаев on 01.12.2021.
//

import UIKit
import FSCalendar

class ScheduleViewController: UIViewController {
    
    var calendarHeightConstrait: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
        
    }()
    //MARK: Create the button open calendar
    let showHiddenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Scheduale"
        
        setConstraints()
        
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.scope = .week
        
        showHiddenButton.addTarget(self, action: #selector (showHiddenButtonTaped), for: .touchUpInside)
        
        swipeAction()
    }
    
    @objc func showHiddenButtonTaped() {
        
        if calendar.scope == .week{
            calendar.setScope(.month, animated: true)
            showHiddenButton.setTitle("Close calendar", for: .normal )
        }else {
            calendar.setScope(.week, animated: true)
            showHiddenButton.setTitle("Open calendar", for: .normal )
            
        }
    }
    
    //MARK:SwapeGestureRecognizer
    
    func swipeAction(){
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func handleSwipe(gesture:UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up:
            showHiddenButtonTaped()
        case .up:
            showHiddenButtonTaped()
        default:
            break
        }
    }
}

//MARK: FSCalendarDataSource, FSCalendarDelegate

extension ScheduleViewController: FSCalendarDataSource, FSCalendarDelegate{
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstrait.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
}

//MARK: SetConstraints

extension ScheduleViewController {
    
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
    }
}

