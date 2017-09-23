//
//  CellItemModels.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/20.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation

struct DiscoverCellItem : Publishable{
    enum ModelType {
        case Movie
        case People
    }
    let name:String
    let array:Array<BaseModel>
    
    init(_ name:String, list:Array<BaseModel>) {
        self.name = name
        self.array = list
    }
}

struct PeopleOfMovieDetailItem : Publishable{
    var id:Int?
    let castItems:Array<CastItem>
    let crewItems:Array<CrewItem>
    
    init(_ datas:Dictionary<String,Any>?) {
        id = datas?["id"] as? Int
        castItems = CastItem.modelArrOfDic(datas) as! Array<CastItem>
        crewItems = CrewItem.modelArrOfDic(datas) as! Array<CrewItem>
    }
}
