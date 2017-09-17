//
//  API.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/12.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation
import RxSwift
import Moya

typealias ValidationResult = (valid:Bool?, message:String?)

/**
 * 网络请求分两种情况
 * 1. 单独的网络请求，只有一个地方用到，使用闭包进行回调获取结果
 * 2. 多处复用的网络请求，可能影响到一个或多个地方的UI，使用Subject发送事件进行解耦
 **/
class APIService {
    
    static let rxProvider = RxMoyaProvider<API>.init()
    static let disposeBag = DisposeBag.init()
    
    static let discoverCycleSubject = PublishSubject<Array<BaseModel>>()
    static let popularMovieSubjcet = PublishSubject<Array<BaseModel>>()
    static let popularPeopleSubject = PublishSubject<Array<BaseModel>>()
    static let topRatedMovieSubject = PublishSubject<Array<BaseModel>>()
    static let upcomingMovieSubject = PublishSubject<Array<BaseModel>>()
    static let playingMovieSubject = PublishSubject<Array<BaseModel>>()
    
    // 获取token, 获取到token后需要加载webView对token进行授权，授权后获取session_id
    public class func requestToken() -> () {
        rxProvider.request(.token).subscribe { (event) in
            switch event {
            case .next(let element):
                let dic:Dictionary<String, Any>? = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as! Dictionary<String, Any>
                if dic?["success"] as! Bool {
                    var account = Account.defaultAccount
                    account.token = dic?["request_token"] as? String
                    account.tokenExpiresTime = dic?["expires_at"] as? String
                    Account.saveAccount(account)
                    debugPrint(account)
                }else{
                    
                }
                break
            case .error(let error):
                debugPrint(error)
            case .completed:
                break
            }
        }.addDisposableTo(disposeBag)
    }
    
    // 获取Session
    public class func requestSession() -> () {
        rxProvider.request(.session).subscribe { (event) in
            switch event {
            case .next(let element):
                let dic:Dictionary<String, Any>? = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as! Dictionary<String, Any>
                if dic?["success"] as! Bool {
                    var account = Account.defaultAccount
                    account.session = dic?["session_id"] as? String
                    Account.saveAccount(account)
                    debugPrint(account)
                }else{
                    
                }
                break
            case .error(let error):
                debugPrint(error)
            case .completed:
                break
            }
            }.addDisposableTo(disposeBag)
    }
    
    public class func request(_ apiType:API) {
        rxProvider.request(apiType).subscribe { (event) in
            switch event {
            case .next(let element):
                // json to Dictionary
                let dic:Dictionary<String, Any>? = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as! Dictionary<String, Any>
                
                // Dictionary to models
                switch apiType {
                case .discover:
                    APIService.discoverCycleSubject.onNext(MovieItem.modelArrOfDic(dic))
                    break
                case .popularPeople:
                    APIService.popularPeopleSubject.onNext(PeopleItem.modelArrOfDic(dic))
                    break
                case .popularMovie:
                    APIService.popularMovieSubjcet.onNext(MovieItem.modelArrOfDic(dic))
                    break
                case .topRatedMovie:
                    APIService.topRatedMovieSubject.onNext(MovieItem.modelArrOfDic(dic))
                    break
                case .upcomingMovie:
                    APIService.upcomingMovieSubject.onNext(MovieItem.modelArrOfDic(dic))
                    break
                case .playingMovie:
                    APIService.playingMovieSubject.onNext(MovieItem.modelArrOfDic(dic))
                    break
                default:
                    break
                }
                break
            case .error(let error):
                debugPrint("Error:\(apiType),Info:\(error)")
                break
            case .completed:
                break
            }
        }.addDisposableTo(disposeBag)
    }
}

enum API {
    // 授权
    case token
    case session
    // 登录，官方不推荐使用此方法
    // 参数：api_key/username/password/request_token
    case signUp(String, String)
    case signUpAsGuast
    // Discover
    case discover
    case popularPeople
    case popularMovie
    case topRatedMovie
    case upcomingMovie
    case playingMovie
}

extension API:TargetType {
    var baseURL: URL {
        switch self {
            
        default:
            return URL.init(string: "https://api.themoviedb.org/3")!
        }
    }
    
    var path: String {
        switch self {
        case .token:
            return "/authentication/token/new"
        case .session:
            return "/authentication/session/new"
        case .signUp(_, _):
            return "/authentication/token/validate_with_login"
        case .signUpAsGuast:
            return "/authentication/guest_session/new"
        case .discover:
            return "/discover/movie"
        case .popularPeople:
            return "/person/popular"
        case .popularMovie:
            return "/movie/popular"
        case .topRatedMovie:
            return "/movie/top_rated"
        case .upcomingMovie:
            return "/movie/upcoming"
        case .playingMovie:
            return "/movie/now_playing"
        }
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .session:
            let token:String? = Account.defaultAccount.token
            if let aToken = token {
                return ["api_key": APIKey,
                        "request_token": aToken]
            }
            return ["api_key": APIKey]
        default:
            return ["api_key": APIKey]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    // 测试用的数据
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return Task.request
    }
    
}

enum Download {
    case image(String)
}

extension Download {
    
}
