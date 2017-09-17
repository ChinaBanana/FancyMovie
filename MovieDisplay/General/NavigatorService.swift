//
//  NavigatorService.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 16/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit
/**
 Navigation service
 对页面跳转进行解耦
 */
class NavigatorService {
    
    init() {
        
    }
    
    // 导航到视图
    class func navigateToPage(_ viewCon:UIViewController, animated:Bool) -> () {
        let rootCon = UIApplication.shared.keyWindow?.rootViewController
        if let tabCon = rootCon as? UITabBarController {
            if let selectedCon = tabCon.selectedViewController as? UINavigationController{
                selectedCon.pushViewController(viewCon, animated: animated)
            }else{
                debugPrint("Current ViewController is not a NavigationController, can not push to viewCon:\(viewCon)")
            }
        }else if let navigationCon = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController{
            navigationCon.navigationController?.pushViewController(viewCon, animated: animated)
        }else {
            debugPrint("Current ViewController is not a NavigationController, can not push to viewCon:\(viewCon)")
            let newNavigationCon = UINavigationController.init(rootViewController: rootCon!)
            newNavigationCon.navigationController?.pushViewController(viewCon, animated: animated)
        }
    }
    
    class func pop(_ animated:Bool) {
        let rootCon = UIApplication.shared.keyWindow?.rootViewController
        if let tabCon = rootCon as? UITabBarController {
            if let selectedCon = tabCon.selectedViewController as? UINavigationController{
                selectedCon.popViewController(animated: animated)
            }else{
                debugPrint("Current ViewController is not a NavigationController, can not pop")
            }
        }else if let navigationCon = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController{
            navigationCon.popViewController(animated: animated)
        }else {
            debugPrint("Current ViewController is not a NavigationController, can not pop")
        }
    }
    
    // 模态视图
    class func modelToPage(_ viewCon:UIViewController, animated:Bool, completion:@escaping () -> ()) -> () {
        let rootCon = UIApplication.shared.keyWindow?.rootViewController
        if let modelCon = rootCon {
            modelCon.present(viewCon, animated: animated, completion: {
                completion()
            })
        }
    }
    
    class func dismiss(_ animated:Bool, completion:@escaping () -> ()) {
        let rootCon = UIApplication.shared.keyWindow?.rootViewController
        if let modelCon = rootCon {
            if modelCon.presentationController != nil {
                modelCon.dismiss(animated: animated, completion: {
                    completion()
                })
            }else{
                debugPrint("Current viewcon is not a model con, can not dismiss")
            }
        }
    }
}
