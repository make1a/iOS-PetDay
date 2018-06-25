//
//  CalendarViewController.swift
//  Calendar
//
//  Created by Fidetro on 21/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit
import SnapKit
import Hero
fileprivate extension Selector {
    static let onLeftClick = #selector(CalendarViewController.onLeftClick(sender:))
    static let onRightClick = #selector(CalendarViewController.onRightClick(sender:))
    static let onMenuClick = #selector(CalendarViewController.onMenuClick(sender:))
    
}

class CalendarViewController: UIViewController,
CustomControllerProtocol,
CalendarContainerViewProtocol {
    
    lazy var containerView: CalendarContainerView = {
        var containerView = CalendarContainerView()
        view.addSubview(containerView)
        containerView.delegate = self
        return containerView
    }()

    
    func localNeedUpdate(sender: UIButton) {
        LocationHelper.locationUpdate { (location, reGeocode) in
            print(reGeocode.city)
        }
    }
    
    func clickPhotoAction(sender: UIButton, countLabel: UILabel) {

        let cameraAction = UIAlertAction.init(title: "Camera", style: .default) { (_) in
            self.navigationController?.pushViewController(CameraViewController(), animated: true)
        }
        let albumAction = UIAlertAction.init(title: "Choose from Album", style: .default) { (_) in
            let baseNav = BaseNavigationController.init(rootViewController: PhotoLibraryViewController())
            baseNav.hero.isEnabled = true
            baseNav.hero.navigationAnimationTypeString = "fade"
            self.present(baseNav, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        presentAlert(title: MyLocalizedString("Upload Photo"), message: nil, preferredStyle: .actionSheet, actions: [cameraAction,albumAction,cancelAction])
    }
    
    func clickMainControlAction(sender: UIButton) {
        let mainVC = MainControlViewController()
        mainVC.modalPresentationStyle = .overFullScreen
        mainVC.hero.isEnabled = true
        present(mainVC, animated: true, completion: nil)
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snpLayoutSubview()
        containerView.refreshEvent()
        setNavigationStyle()
        view.backgroundColor = .themeBlackColor()
        
    }
    
    
    @objc func onLeftClick(sender:UIButton) {
        DateHelper.shared.last()
        setNavigationStyle()
        containerView.refreshEvent()
        
    }
    
    @objc func onRightClick(sender:UIButton) {
        DateHelper.shared.next()
        setNavigationStyle()
        containerView.refreshEvent()
    }
    
    @objc func onMenuClick(sender:UIButton) {
        let calendarVC = DayListViewController()
        navigationController?.hero.navigationAnimationType = .zoom
        navigationController?.hero.isEnabled = true
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    func refreshEvent() {
        
    }
    
    func setNavigationStyle() {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM"
        navigationItem.setupNavigationItem(items: [UIImage.init(named: "nav_left")!],
                                           orientation: .left,
                                           actions: [.onLeftClick],
                                           target: self)
        navigationItem.setupNavigationItem(items: [UIImage.init(named: "nav_right")!,
                                                   10,
                                                   UIImage.init(named: "icon_menu")!],
                                           orientation: .right,
                                           actions: [.onRightClick,nil,.onMenuClick],
                                           target: self)
        setTitle(formatter.string(from: DateHelper.shared.today), color: .white)
        setNavigationBar(color: .themeBlackColor())
    }
    
    func snpLayoutSubview() {
        containerView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
}
