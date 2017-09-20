//
//  Protocols.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation
import RxSwift

protocol Publishable {
    
}

protocol BaseService {
    static func publish(_ element:Publishable) -> ()
    
}

protocol BaseViewModel {
    var refreshUISubject:PublishSubject<Publishable> { get }
}

protocol BaseModel:Publishable {
    init(_ dic:Dictionary<String, Any>)
}

protocol BaseDicModelProtocl:BaseModel {
    static func modelArrOfDic(_ modelDic:Dictionary<String, Any>?) -> Array<BaseModel>
    static func modelArrOfDicArray(_ dicArray:Array<Dictionary<String, Any>>) -> Array<BaseModel>
}
