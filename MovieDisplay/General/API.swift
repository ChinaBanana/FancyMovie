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
    static let provider = MoyaProvider<API>.init()
    static let disposeBag = DisposeBag.init()
    
    static let discoverCycleSubject = PublishSubject<Array<MovieItem>>()
    static let popularMovieSubjcet = PublishSubject<Array<MovieItem>>()
    static let popularPeopleSubject = PublishSubject<Array<MovieItem>>()
    
    // 模拟验证用户名可用性
    public class func usernameAvailable(_ username:String?, succeed:@escaping ((_ result:Bool) -> ())) -> () {
        DispatchQueue.init(label: "com.vavidateusername.queue").asyncAfter(deadline: DispatchTime.now() + 1) {
            let num = arc4random() % 2
            if num == 1 {
                succeed(true)
            }else{
                succeed(false)
            }
        }
    }
    // 获取token, 获取到token后需要加载webView对token进行授权，授权后获取session_id
    public class func requestToken() -> () {
        provider.request(.token) { (result) in
            debugPrint("requestToken:\(result)")
            do {
                let response = try result.dematerialize()
                let data = response.data
                let dic:Dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>
                if dic["success"] as! Bool {
                    var account = Account.defaultAccount
                    account.token = dic["request_token"] as? String
                    account.tokenExpiresTime = dic["expires_at"] as? String
                    Account.saveAccount(account)
                    debugPrint(account)
                }else{
                    
                }
            }catch {
                
            }
        }
    }
    
    // 获取Session
    public class func requestSession() -> () {
        provider.request(.session) { (result) in
            debugPrint("requestSession:\(result)")
            do {
                let response = try result.dematerialize()
                let data = response.data
                let dic:Dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>
                debugPrint(dic)
                var account = Account.defaultAccount
                account.session = dic["session_id"] as? String
                Account.saveAccount(account)
            }catch {
                
            }
        }
    }
    
    public class func requestDiscover() {
        rxProvider.request(.discover).subscribe { (event) in
            switch event {
            case .next(let element):
                let dic:Dictionary<String, Any>? = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as! Dictionary<String, Any>
                let modelArr = MovieItem.modelArrOfDic(dic)
                APIService.discoverCycleSubject.onNext(modelArr)
                break
            case .error(let error):
                debugPrint(error)
                break
            case .completed:
                break
            }
        }.addDisposableTo(APIService.disposeBag)
    }
    
    // 获取热门电影列表
    public class func requestPopularMovie() {
        rxProvider.request(.popularMovie).subscribe { (event) in
            switch event {
            case .next(let element):
                let dic:Dictionary<String, Any>? = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as! Dictionary<String, Any>
                let modelArr = MovieItem.modelArrOfDic(dic)
            case .error(_):
                break
            case .completed:
                break
            }
        }.addDisposableTo(APIService.disposeBag)
    }
    
    // 获取热门人物列表
    public class func requestPopularPelple() {
        rxProvider.request(.popularPeople).subscribe { (event) in
            switch event {
            case .next(let element):
                let dic:Dictionary<String, Any>? = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as! Dictionary<String, Any>
                
            case .error(_):
                break
            case .completed:
                break
            }
        }.addDisposableTo(APIService.disposeBag)
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
