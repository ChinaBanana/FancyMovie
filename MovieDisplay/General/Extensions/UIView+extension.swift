//
//  UIView+extension.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/20.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit

/**
 布局用
 */
extension UIView {
    var left:CGFloat {
        set {
            self.frame = CGRect.init(origin: CGPoint.init(x: newValue, y: self.frame.origin.y), size: self.frame.size)
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var top:CGFloat {
        set {
            self.frame = CGRect.init(origin: CGPoint.init(x: self.frame.origin.x, y: newValue), size: self.frame.size)
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var right:CGFloat {
        set {
            self.frame = CGRect.init(origin: CGPoint.init(x: newValue - self.frame.size.width, y: self.frame.origin.y), size: self.frame.size)
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    var height:CGFloat {
        set {
            self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newValue)
        }
        get {
            return self.bounds.size.height
        }
    }
    
    var width:CGFloat {
        set {
            self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.frame.size.height)
        }
        get {
            return self.bounds.size.width
        }
    }
    
    var bottom:CGFloat {
        set {
            self.frame = CGRect.init(origin: CGPoint.init(x: self.frame.origin.x, y: newValue - self.frame.size.height), size: self.frame.size)
        }
        get {
            return self.frame.size.height + self.frame.origin.y
        }
    }
    
    var centerX:CGFloat {
        set {
            self.center = CGPoint.init(x: newValue, y: self.center.y)
        }
        get {
            return self.center.x
        }
    }
    
    var centerY:CGFloat {
        set {
            self.center = CGPoint.init(x: self.center.x, y: newValue)
        }
        get {
            return self.center.y
        }
    }
}
/*
 自定义View
 */
extension UIView {
    func setBottomLine() -> () {
        let line = UIView.init(frame: CGRect.init(x: 0, y: self.height - 1, width: self.width, height: 1))
        line.backgroundColor = UIColor.init(white: 0.2, alpha: 0.5)
        self.addSubview(line)
    }
    
    func setScreenWidthBottomLine() -> () {
        let line = UIView.init(frame: CGRect.init(x: 0, y: self.height - 1, width: kScreenWidth, height: 1))
        line.centerX = self.width / 2
        line.backgroundColor = UIColor.init(white: 0.2, alpha: 0.5)
        self.addSubview(line)
    }
}
