//
//  Protocols.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation

protocol BaseModel:NSProxy {
    static func modelArrOfDic(_ modelDic:Dictionary<String, Any>?) -> Array<self.class>
}
