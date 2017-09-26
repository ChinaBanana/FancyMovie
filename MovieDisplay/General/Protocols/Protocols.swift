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

/**
 在service中使用了很多的Subject，但是由于Subject属于一个很强大的东西，大神们并不推荐大量使用这个元素
 
 */
protocol BaseService {
    static func publish(_ element:Publishable) -> ()
    
}

protocol BaseViewModel {
    var refreshUISubject:PublishSubject<Publishable> { get }
}

protocol BaseModel:Publishable {
    init(_ dic:Dictionary<String, Any>?)
}

protocol BaseDicModelProtocl:BaseModel {
    static func modelArrOfDic(_ modelDic:Dictionary<String, Any>?) -> Array<BaseModel>
    static func modelArrOfDicArray(_ dicArray:Array<Dictionary<String, Any>>) -> Array<BaseModel>
}

protocol Layout {
    var width:CGFloat { get set }
    var height:CGFloat { get set }
    var left:CGFloat { get set }
    var top:CGFloat { get set }
    var right:CGFloat { get set }
    var bottom:CGFloat { get set }
}
