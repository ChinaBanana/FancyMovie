//
//  MyTMDbViewModel.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/12.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation
import RxSwift

class MyTMDbViewModel {
    
    let disposeBag = DisposeBag.init()
    let validateSubject = PublishSubject<ValidationResult>()
    
    init() {
        
    }
    
    public func validateUserName(_ username:String?) {
        if username?.characters.count == 0 {
            validateSubject.onNext((false, nil))
        }else if username?.rangeOfCharacter(from: NSCharacterSet.alphanumerics.inverted) != nil {
            validateSubject.onNext((false, "Username can only contain numbers or characters"))
        }else{
//            ProgressView.showProgress("loading...")
            
        }
    }
    
    public func loginAccount(_ account:String?, password:String?) -> () {
        
    }
}
