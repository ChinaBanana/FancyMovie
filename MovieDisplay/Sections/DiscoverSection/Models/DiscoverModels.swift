//
//  DiscoverModels.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/14.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation

struct MovieItem {
    var vote_count:Int?
    var vote_average:Int?
    var id:Int?
    var video:Bool?
    var title:String?
    var popularity:Int?
    var poster_path:String?
    var original_language:String?
    var original_title:String?
    var genre_ids:Array<Int>?
    var backdrop_path:String?
    var adult:Bool?
    var overview:String?
    var release_date:String?
    init(_ dic:Dictionary<String, Any>) {
        vote_count = dic["vote_count"] as? Int
        vote_average = dic["vote_average"] as? Int
        id = dic["id"] as? Int
        video = dic["video"] as? Bool
        title = dic["title"] as? String
        popularity = dic["popularity"] as? Int
        poster_path = dic["poster_path"] as? String
        original_title = dic["original_title"] as? String
        original_language = dic["original_language"] as? String
        genre_ids = dic["genre_ids"] as? Array<Int>
        backdrop_path = dic["backdrop_path"] as? String
        adult = dic["adult"] as? Bool
        overview = dic["overview"] as? String
        release_date = dic["release_date"] as? String
    }
    
    static func modelArrOfDic(_ modelDic:Dictionary<String, Any>?) -> Array<MovieItem> {
        var modelArr = [MovieItem]()
        if let dic = modelDic {
            let items = dic["results"] as? Array<Dictionary<String, Any>>
            if let itemData = items {
                modelArr.append(contentsOf: modelArrOfDicArray(itemData))
            }
        }
        return modelArr
    }
    
    static func modelArrOfDicArray(_ dicArray:Array<Dictionary<String, Any>>) -> Array<MovieItem> {
        var responsArr = [MovieItem]()
        for item in dicArray {
            let movieModel = MovieItem.init(item)
            responsArr.append(movieModel)
        }
        return responsArr
    }
}

struct PeopleItem {
    var profile_path:String?
    var adult:Bool?
    var id:Int?
    var known_for:Array<MovieItem>?
    var name:String?
    var popularity:Int?
    init(_ dic:Dictionary<String,Any>) {
        profile_path = dic["profile_path"] as? String
        adult = dic["adult"] as? Bool
        id = dic["id"] as? Int
        name = dic["name"] as? String
        popularity = dic["popularity"] as? Int
        if let knownForList = dic["known_for"] as? Array<Dictionary<String, Any>> {
            known_for = MovieItem.modelArrOfDicArray(knownForList)
        }
    }
}

struct DiscoverCellItem {
    let name:String
    var array:Array = [MovieItem]()
    init(_ name:String) {
        self.name = name
    }
}


