//
//  ImageUrl.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation

class ImageUrl {
    static let baseUrl = "http://image.tmdb.org/t/p/"
    static let secureBaseUrl = "https://image.tmdb.org/t/p/"
    
    enum ImageType {
        case backdrop
        case logo
        case poster
        case profile
        case still
    }
    
    enum backdrop_sizes {
        case w300
        case w780
        case w1280
        case original
    }
    enum logo_sizes {
        case w45
        case w92
        case w154
        case w185
        case w300
        case w500
        case original
    }
    enum poster_sizes {
        case w92
        case w154
        case w185
        case w342
        case w500
        case w780
        case original
    }
    
    enum profile_sizes {
        case w45
        case w185
        case w632
        case original
    }
    
    enum still_sizes {
        case w92
        case w185
        case w300
        case original
    }
    
    class func thumbImage(_ path:String?, type:ImageType) -> URL? {
        if let aPath = path {
            switch type {
            case .backdrop:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(backdrop_sizes.w300)" + aPath)
            case .logo:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(logo_sizes.w154)" + aPath)
            case .poster:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(poster_sizes.w92)" + aPath)
            case .profile:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(profile_sizes.w45)" + aPath)
            case .still:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(still_sizes.w92)" + aPath)
            }
        }
        return nil
    }
}
