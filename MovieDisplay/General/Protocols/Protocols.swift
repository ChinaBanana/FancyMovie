//
//  Protocols.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation

protocol BaseModel {
    init(_ dic:Dictionary<String, Any>)
    static func modelArrOfDic(_ modelDic:Dictionary<String, Any>?) -> Array<BaseModel>
    static func modelArrOfDicArray(_ dicArray:Array<Dictionary<String, Any>>) -> Array<BaseModel>
}
