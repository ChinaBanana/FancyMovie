//
//  RootViewController.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/12.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(DiscoverViewController(), title: "Discover", icon: UIImage.init(named: "discover_normal"), selectedIcon: UIImage.init(named: "discover_selected"))
        addChildViewController(SearchViewController(), title: "Search", icon: UIImage.init(named: "search_normal"), selectedIcon: UIImage.init(named: "search_selected"))
        addChildViewController(MyTMDbViewController(), title: "My TMDb", icon: UIImage.init(named: "my_TMDb_normal"), selectedIcon: UIImage.init(named: "my_TMDb_selected"))
    }
    
    fileprivate func addChildViewController(_ childCon:UIViewController, title:String, icon:UIImage?, selectedIcon:UIImage?) {
        let naviCon = UINavigationController.init(rootViewController: childCon)
        naviCon.tabBarItem = UITabBarItem.init(title: title, image: icon?.withRenderingMode(.alwaysOriginal), selectedImage: selectedIcon?.withRenderingMode(.alwaysOriginal))
        self.addChildViewController(naviCon)
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
