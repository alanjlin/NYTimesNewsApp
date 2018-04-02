//
//  TabBarController.swift
//  New York Times
//
//  Created by Alan Lin on 12/1/17.
//  Copyright © 2017 Alan Lin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mostPopularViewController = MostPopularViewController()
        mostPopularViewController.tabBarItem = UITabBarItem(title: "Most Popular", image: #imageLiteral(resourceName: "Gold_Star"), tag: 0)
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let viewControllerList = [ mostPopularViewController, searchViewController]
        viewControllers = viewControllerList
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
