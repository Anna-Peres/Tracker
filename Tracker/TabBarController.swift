//
//  TabBarController.swift
//  Tracker
//
//  Created by Анна Перескокова on 24.05.2025.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .ypWhite
        tabBar.frame.size.height = 84
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.ypGray.cgColor
        
        let trackersViewController = TrackersViewController()
        trackersViewController.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "Trackers_tab"),
            selectedImage: nil
        )
        
        let statisticsViewController = StatisticsViewController()
        statisticsViewController.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "Statistics_tab"),
            selectedImage: nil
        )
        
        self.viewControllers = [trackersViewController, statisticsViewController]
    }
}
