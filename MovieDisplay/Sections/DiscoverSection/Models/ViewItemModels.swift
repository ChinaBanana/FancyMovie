//
//  CellItemModels.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/20.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation

struct DiscoverCellItem {
    enum ModelType {
        case Movie
        case People
    }
    let name:String
    var array:Array = [BaseModel]()
    
    var modelType:ModelType {
        get {
            switch name {
            case "Popular People":
                return .People
            default:
                return .Movie
            }
        }
    }
    
    init(_ name:String, list:Array<BaseModel>) {
        self.name = name
        self.array = list
    }
}
