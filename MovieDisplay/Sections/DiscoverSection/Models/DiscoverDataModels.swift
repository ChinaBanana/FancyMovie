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
    
    init(_ datas:Dictionary<String, Any>?) {
        if let dic = datas {
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
    }
    
    static func modelArrOfDic(_ modelDic:Dictionary<String, Any>?) -> Array<BaseModel> {
        if let itemData = modelDic?["results"] as? Array<Dictionary<String, Any>> {
            return modelArrOfDicArray(itemData)
        }
        return [MovieItem]()
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
    var genres:Array<Genres>?
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
    let layout:OverviewLayout
    init(_ datas: Dictionary<String, Any>?) {
        if let dic = datas {
            adult = dic["adult"] as? Bool
            backdrop_path = dic["backdrop_path"] as? String
            belongs_to_collection = dic["belongs_to_collection"] as? Array
            budget = dic["budget"] as? Int
            genres = Genres.modelArrOfDicArray(dic["genres"] as? Array)
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
        layout = OverviewLayout.init(datas)
    }
}

struct Genres : BaseModel {
    var name:String?
    var id:Int?
    init(_ dic: Dictionary<String, Any>?) {
        name = dic?["name"] as? String
        id = dic?["id"] as? Int
    }
    
    static func modelArrOfDicArray(_ dicArray: Array<Dictionary<String, Any>>?) -> Array<Genres> {
        var responseArr = [Genres]()
        if let datasArr = dicArray {
            for item in datasArr {
                responseArr.append(Genres.init(item))
            }
        }
        return responseArr
    }
}

struct PeopleItem : BaseDicModelProtocl {
    var profile_path:String?
    var adult:Bool?
    var id:Int?
    var known_for:Array<BaseModel>?
    var name:String?
    var popularity:Int?
    init(_ datas:Dictionary<String,Any>?) {
        if let dic = datas {
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
    
    static func modelArrOfDic(_ modelDic: Dictionary<String, Any>?) -> Array<BaseModel> {
        if let itemData = modelDic?["results"] as? Array<Dictionary<String, Any>> {
            return modelArrOfDicArray(itemData)
        }
        return [BaseModel]()
    }
    
    static func modelArrOfDicArray(_ dicArray: Array<Dictionary<String, Any>>) -> Array<BaseModel> {
        var responseArr = [BaseModel]()
        for item in dicArray {
            responseArr.append(PeopleItem.init(item))
        }
        return responseArr
    }
}

struct CastItem : BaseDicModelProtocl {
    
    var cast_id:Int?
    var character:String?
    var credit_id:String?
    var gender:Int?
    var id:Int?
    var name:String?
    var order:Int?
    var profile_path:String?
    
    init(_ dic: Dictionary<String, Any>?) {
        if let datas = dic{
            cast_id = datas["cast_id"] as? Int
            character = datas["character"] as? String
            credit_id = datas["credit_id"] as? String
            gender = datas["gender"] as? Int
            id = datas["id"] as? Int
            name = datas["name"] as? String
            order = datas["order"] as? Int
            profile_path = datas["profile_path"] as? String
        }
    }
    
    static func modelArrOfDic(_ modelDic: Dictionary<String, Any>?) -> Array<BaseModel> {
        if let casts = modelDic?["cast"] as? Array<Dictionary<String, Any>> {
            return modelArrOfDicArray(casts)
        }
        return [CastItem]()
    }
    
    static func modelArrOfDicArray(_ dicArray: Array<Dictionary<String, Any>>) -> Array<BaseModel> {
        var modelArr = [CastItem]()
        for item in dicArray {
            modelArr.append(CastItem.init(item))
        }
        return modelArr
    }
}

struct CrewItem : BaseDicModelProtocl {
    
    var credit_id:String?
    var department:String?
    var gender:Int?
    var id:Int?
    var job:String?
    var name:String?
    var profile_path:String?
    
    init(_ dic: Dictionary<String, Any>?) {
        if let data = dic{
            credit_id = data["credit_id"] as? String
            department = data["department"] as? String
            gender = data["gender"] as? Int
            id = data["id"] as? Int
            job = data["job"] as? String
            name = data["name"] as? String
            profile_path = data["profile_path"] as? String
        }
    }
    
    static func modelArrOfDic(_ modelDic: Dictionary<String, Any>?) -> Array<BaseModel> {
        if let dicArr = modelDic?["crew"] as? Array<Dictionary<String, Any>> {
            return modelArrOfDicArray(dicArr)
        }
        return [CrewItem]()
    }
    
    static func modelArrOfDicArray(_ dicArray: Array<Dictionary<String, Any>>) -> Array<BaseModel> {
        var modelArr = [CrewItem]()
        for item in dicArray {
            modelArr.append(CrewItem.init(item))
        }
        return modelArr
    }
}

struct TrailerItem : BaseDicModelProtocl {
    var id:String?
    var iso_639_1:String?
    var iso_3166_1:String?
    var key:String?
    var name:String?
    var site:String?
    var size:Int?
    var type:String?

    init(_ dic: Dictionary<String, Any>?) {
        if let data = dic {
            id = data["id"] as? String
            iso_639_1 = data["iso_639_1"] as? String
            iso_3166_1 = data["iso_3166_1"] as? String
            key = data["key"] as? String
            name = data["name"] as? String
            site = data["site"] as? String
            size = data["size"] as? Int
            type = data["type"] as? String
        }
    }
    
    static func modelArrOfDic(_ modelDic: Dictionary<String, Any>?) -> Array<BaseModel> {
        if let datas = modelDic?["results"] as? Array<Dictionary<String, Any>>{
            return modelArrOfDicArray(datas)
        }
        return [TrailerItem]()
    }
    
    static func modelArrOfDicArray(_ dicArray: Array<Dictionary<String, Any>>) -> Array<BaseModel> {
        var modelArr = [TrailerItem]()
        for item in dicArray {
            modelArr.append(TrailerItem.init(item))
        }
        return modelArr
    }
}



