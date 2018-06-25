//
//  DayListViewController.swift
//  iOS-etDay
//
//  Created by Fidetro on 03/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let onLeftClick = #selector(CalendarViewController.onLeftClick(sender:))
    static let onRightClick = #selector(CalendarViewController.onRightClick(sender:))
}
class DayListViewController:
    UIViewController,
    CustomControllerProtocol,
    UITableViewDelegate,
UITableViewDataSource {

    
    var days = [Day]()
    
    lazy var containerView: DayListContainerView = {
        let containerView = DayListContainerView()
        containerView.tableView.delegate = self
        containerView.tableView.dataSource = self
        view.addSubview(containerView)
        return containerView
    }()
    
    deinit {
        print("释放")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .themeBlackColor()
        setNavigationStyle()
        snpLayoutSubview()
        refreshEvent()
        
    }
    
    func refreshEvent() {
        let calculator = DateCalculator.init(today: Date())
        let count = 365
        days.append(contentsOf: calculator.lastDays(count: count))
        days.append(calculator.today)
        days.append(contentsOf: calculator.nextDays(count: count))
        self.containerView.tableView.reloadData()
        self.containerView.tableView.scrollToRow(at: IndexPath.init(row: 0, section: count - 1), at: .top, animated: false)
    }
    
    @objc func onLeftClick(sender:UIButton) {

    }
    
    @objc func onRightClick(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationStyle() {
        navigationController?.hero.navigationAnimationType = .zoomOut
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM"
        navigationItem.setupNavigationItem(items: [UIImage.init(named: "nav_left")!],
                                           orientation: .left,
                                           actions: [.onLeftClick],
                                           target: self)
        navigationItem.setupNavigationItem(items: [UIImage.init(named: "icon_menu")!],
                                           orientation: .right,
                                           actions: [.onRightClick],
                                           target: self)
        setNavigationBar(color: .themeBlackColor())
        setTitle(formatter.string(from: DateHelper.shared.today), color: .white)
        
    }
    
    func snpLayoutSubview() {
        containerView.snp.makeConstraints{
            if #available(iOS 11.0, *) {
                $0.top.equalToSuperview()
            } else {
                $0.top.equalToSuperview()
            }
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension DayListViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DayListTableViewCell.dequeueReusable(WithTableView: tableView)
  
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DayListHeaderView.dequeueReusable(tableView: tableView)
        let day = days[section]
        headerView.updateDataSource(day:day)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let tag = "reloadMoreDays"
        let needLoadCount = 30
        if indexPath.section > (days.count - needLoadCount) {
            Timer.add(operation: {
                let calculator = DateCalculator.init(today: self.days.last!)
                let newDays = calculator.nextDays(count: 365)
                self.days.append(contentsOf:newDays)
                OperationQueue.main.addOperation({
                    self.containerView.tableView.reloadData()
                })
            }, interval: 0.5, tag: tag)
        }else if indexPath.section < needLoadCount {
            Timer.add(operation: {
                let calculator = DateCalculator.init(today: self.days.first!)
                let newDays = calculator.lastDays(count: 365)
                
                self.days.insert(contentsOf: newDays, at: 0)
                OperationQueue.main.addOperation({
                    self.containerView.tableView.reloadData()
                    self.containerView.tableView.scrollToRow(at: IndexPath.init(row: 0, section: newDays.count + needLoadCount), at: .top, animated: false)
                    
                })
            }, interval: 0.5, tag: tag)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
