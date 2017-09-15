//
//  ProgressView.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/13.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit

class ProgressView {
    
    static let defaultView = ProgressView.init()
    
    let view:UIView!
    let activityView:UIActivityIndicatorView!
    let messageLabel:UILabel = UILabel.init()
    
    init() {
        view = UIView.init(frame: UIScreen.main.bounds)
        activityView = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        activityView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        activityView.layer.cornerRadius = 5
        activityView.clipsToBounds = true
        activityView.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 120)
        activityView.center = view.center
        view.addSubview(activityView)
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor.white
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.activityView)
            make.height.equalTo(50)
        }
    }
    
    public class func showProgress(_ message:String?) {
        if Thread.current.isMainThread {
            UIApplication.shared.keyWindow?.addSubview(ProgressView.defaultView.view)
            ProgressView.defaultView.activityView.startAnimating()
            ProgressView.defaultView.messageLabel.text = message
        }else {
            DispatchQueue.main.async {
                UIApplication.shared.keyWindow?.addSubview(ProgressView.defaultView.view)
                ProgressView.defaultView.activityView.startAnimating()
                ProgressView.defaultView.messageLabel.text = message
            }
        }
    }
    
    public class func dismissProgress() {
        if Thread.current.isMainThread {
            ProgressView.defaultView.activityView.stopAnimating()
            ProgressView.defaultView.view.removeFromSuperview()
        }else{
            DispatchQueue.main.async {
                ProgressView.defaultView.activityView.stopAnimating()
                ProgressView.defaultView.view.removeFromSuperview()
            }
        }
    }
}
