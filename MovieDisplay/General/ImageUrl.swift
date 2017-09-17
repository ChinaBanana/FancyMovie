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
        case backdrop // 宽高比 300:169
        case logo
        case poster   // 宽高比：92:138
        case profile  // 宽高比：185:278 和.poster 一致
        case still
    }
    
    private enum backdrop_sizes {
        case w300
        case w780
        case w1280
        case original
    }
    private enum logo_sizes {
        case w45
        case w92
        case w154
        case w185
        case w300
        case w500
        case original
    }
    private enum poster_sizes {
        case w92
        case w154
        case w185
        case w342
        case w500
        case w780
        case original
    }
    
    private enum profile_sizes {
        case w45
        case w185
        case w632
        case original
    }
    
    private enum still_sizes {
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
    
    class func standardImage(_ path:String?, type:ImageType) -> URL?{
        if let aPath = path {
            switch type {
            case .backdrop:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(backdrop_sizes.w780)" + aPath)
            case .logo:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(logo_sizes.w185)" + aPath)
            case .poster:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(poster_sizes.w342)" + aPath)
            case .profile:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(profile_sizes.w185)" + aPath)
            case .still:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(still_sizes.w185)" + aPath)
            }
        }
        return nil
    }
    
    class func largeImage(_ path:String?, type:ImageType) -> URL? {
        if let aPath = path {
            switch type {
            case .backdrop:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(backdrop_sizes.w1280)" + aPath)
            case .logo:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(logo_sizes.w500)" + aPath)
            case .poster:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(poster_sizes.w780)" + aPath)
            case .profile:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(profile_sizes.w632)" + aPath)
            case .still:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(still_sizes.w300)" + aPath)
            }
        }
        return nil
    }
    
    class func originalImage(_ path:String?, type:ImageType) -> URL? {
        if let aPath = path {
            switch type {
            case .backdrop:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(backdrop_sizes.original)" + aPath)
            case .logo:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(logo_sizes.original)" + aPath)
            case .poster:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(poster_sizes.original)" + aPath)
            case .profile:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(profile_sizes.original)" + aPath)
            case .still:
                return URL.init(string: ImageUrl.secureBaseUrl + "\(still_sizes.original)" + aPath)
            }
        }
        return nil
    }
}
