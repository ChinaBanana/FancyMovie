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
 * 这里对网络层也进行了解耦，实际项目中可根据情况确定是否需要解耦
 * 网络请求分两种情况，为了解耦，多使用方法2
 * 1. 单独的网络请求，只有一个地方用到，使用闭包进行回调获取结果
 * 2. 多处复用的网络请求，可能影响到一个或多个地方的UI，使用Subject发送事件进行解耦
 **/
class APIService : BaseService{
    
    static let rxProvider = RxMoyaProvider<API>.init()
    static let disposeBag = DisposeBag.init()
    static let commonSubject = PublishSubject<Publishable>()
    
    static let discoverCycleSubject = PublishSubject<Array<BaseModel>>()
    static let popularMovieSubjcet = PublishSubject<Array<BaseModel>>()
    static let popularPeopleSubject = PublishSubject<Array<BaseModel>>()
    static let topRatedMovieSubject = PublishSubject<Array<BaseModel>>()
    static let upcomingMovieSubject = PublishSubject<Array<BaseModel>>()
    static let playingMovieSubject = PublishSubject<Array<BaseModel>>()
    static let similarMovieSubject = PublishSubject<Array<BaseModel>>()
    
    public class func publish(_ obj:Publishable) {
        commonSubject.onNext(obj)
    }
    
    // 封装订阅操作
    public class func subscribe(_ condition:@escaping(_ item:Publishable) -> Bool, handler:@escaping(_ element:Publishable)->()) -> Disposable{
        return commonSubject.filter({ (item) -> Bool in
            return condition(item)
        }).subscribe { (event) in
            switch event {
            case .next(let element):
                handler(element)
                break
            case .error(_):
                
                break
            case .completed:
                break
            }
        }
    }
    
    // 根据需要的次数来订阅
    public class func subscribe(_ take:Int?, handler:@escaping (_ element:Publishable)->()) -> Disposable{
        if let num = take {
            return commonSubject.take(num).subscribe({ (event) in
                switch event {
                case .next(let element):
                    handler(element)
                    break
                case .error(let error):
                    debugPrint("Error on \(event) : \(error)")
                    break
                case .completed:
                    break
                }
            })
        }
        return commonSubject.subscribe({ (event) in
                switch event {
                case .next(let element):
                    handler(element)
                    break
                case .error(let error):
                    debugPrint("Error on \(event) : \(error)")
                    break
                case .completed:
                    break
                }
            })
    }
    
    public class func subscribe(_ filter:@escaping(_ item:Publishable) -> Bool, take:Int?, handler:@escaping(_ element:Publishable) -> ()) -> Disposable {
        return commonSubject.filter { (item) -> Bool in
            return filter(item)
            }.take(take ?? 0).subscribe { (event) in
                switch event {
                case .next(let element ):
                    handler(element)
                    break
                case .error(let error):
                    debugPrint(error)
                    break
                case .completed:
                    break
                }
        }
    }
    
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
                case .getSimilar(_):
                    APIService.similarMovieSubject.onNext(MovieItem.modelArrOfDic(dic))
                    break
                case .getMovieDetail(_):
                    APIService.publish(MovieDetailItem.init(dic))
                    break
                case .getVideos(_):
                    
                    break
                case .getMovieCredits(_):
                    APIService.publish(PeopleOfMovieDetailItem.init(dic))
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
    /// 下面这部分没有解耦的必要，这里有点鸡肋，像是为了解耦而解耦
    case getSimilar(Int)
    case getMovieDetail(Int)
    case getVideos(Int)
    case getMovieCredits(Int)
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
        case .getSimilar(let movie_id):
            return "/movie/\(movie_id)/similar"
        case .getMovieDetail(let movie_id):
            return "/movie/\(movie_id)"
        case .getVideos(let movie_id):
            return "/movie/\(movie_id)/videos"
        case .getMovieCredits(let movie_id):
            return "/movie/\(movie_id)/credits"
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
