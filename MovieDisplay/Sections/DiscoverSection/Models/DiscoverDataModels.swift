//
//  DiscoverModels.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/14.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation

struct MovieItem : BaseDicModelProtocl {
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
    
    static func modelArrOfDic(_ modelDic:Dictionary<String, Any>?) -> Array<BaseModel> {
        var modelArr = [BaseModel]()
        if let dic = modelDic {
            let items = dic["results"] as? Array<Dictionary<String, Any>>
            if let itemData = items {
                modelArr.append(contentsOf: modelArrOfDicArray(itemData))
            }
        }
        return modelArr
    }
    
    static func modelArrOfDicArray(_ dicArray:Array<Dictionary<String, Any>>) -> Array<BaseModel> {
        var responsArr = [MovieItem]()
        for item in dicArray {
            responsArr.append(MovieItem.init(item))
        }
        return responsArr
    }
}

struct MovieDetailItem :BaseModel {
    var adult:Bool?
    var backdrop_path:String?
    var belongs_to_collection:Array<Dictionary<String,Any>>?
    var budget:Int?
    var genres:Array<Dictionary<String,Any>>?
    var id:Int?
    var name:String?
    var homepage:String?
    var imdb_id:String?
    var original_language:String?
    var original_title:String?
    var overview:String?
    var popularity:Int?
    var poster_path:String?
    var production_companies:Array<Dictionary<String,Any>>?
    var production_countries:Array<Dictionary<String,Any>>?
    var release_date:String?
    var revenue:Int?
    var runtime:Int? // min
    var spoken_languages:Array<Dictionary<String,Any>>?
    var status:String?
    var tagline:String?
    var title:String?
    var video:Bool?
    var vote_average:Int?
    var vote_count:Int?
    init(_ dic: Dictionary<String, Any>?) {
        adult = dic["adult"] as? Bool
        backdrop_path = dic["backdrop_path"] as? String
        belongs_to_collection = dic["belongs_to_collection"] as? Array
        budget = dic["budget"] as? Int
        genres = dic["genres"] as? Array
        id = dic["id"] as? Int
        name = dic["name"] as? String
        homepage = dic["homepage"] as? String
        imdb_id = dic["imdb_id"] as? String
        original_language = dic["original_language"] as? String
        original_title = dic["original_title"] as? String
        overview = dic["overview"] as? String
        popularity = dic["popularity"] as? Int
        poster_path = dic["poster_path"] as? String
        production_companies = dic["production_companies"] as? Array
        production_countries = dic["production_countries"] as? Array
        release_date = dic["release_date"] as? String
        revenue = dic["revenue"] as? Int
        runtime = dic["runtime"] as? Int
        spoken_languages = dic["spoken_languages"] as? Array
        status = dic["status"] as? String
        tagline = dic["tagline"] as? String
        title = dic["title"] as? String
        video = dic["video"] as? Bool
        vote_average = dic["vote_average"] as? Int
        vote_count = dic["vote_count"] as? Int
    }
}

struct PeopleItem : BaseDicModelProtocl {
    var profile_path:String?
    var adult:Bool?
    var id:Int?
    var known_for:Array<BaseModel>?
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
    
    static func modelArrOfDic(_ modelDic: Dictionary<String, Any>?) -> Array<BaseModel> {
        var responseArr = [BaseModel]()
        if let dic = modelDic {
            let items = dic["results"] as? Array<Dictionary<String, Any>>
            if let itemData = items {
                responseArr.append(contentsOf: modelArrOfDicArray(itemData))
            }
        }
        return responseArr
    }
    
    static func modelArrOfDicArray(_ dicArray: Array<Dictionary<String, Any>>) -> Array<BaseModel> {
        var responseArr = [BaseModel]()
        for item in dicArray {
            responseArr.append(PeopleItem.init(item))
        }
        return responseArr
    }
}




