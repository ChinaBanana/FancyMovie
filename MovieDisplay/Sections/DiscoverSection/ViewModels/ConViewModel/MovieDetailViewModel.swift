//
//  MovieDetailViewModel.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 17/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit
import RxSwift

class MovieDetailViewModel {
    
    enum ReloadType {
        case overview
        case peopleTableView
        case similarTableView
    }
    
    var movieItem:MovieItem?
    var similarMovies:Array<BaseModel> = [BaseModel]()
    
    let refreshSubject = PublishSubject<ReloadType>()
    let disposeBag = DisposeBag.init()
    
    init() {
        NavigatorService.publishSubject.filter { (model) -> Bool in
            if let _ = model as? MovieItem{
                return true
            }
            return false
            }.single().subscribe { (event) in
                switch event {
                case .next(let movieItem):
                    self.movieItem = movieItem as? MovieItem
                    APIService.request(.getSimilar((self.movieItem?.id)!))
                    self.refreshSubject.onNext(ReloadType.overview)
                    break
                case.error(let error):
                    debugPrint("MovieDetailViewModelError:\(error)")
                    break
                case .completed:
                    break
                }
        }.addDisposableTo(NavigatorService.disposeBag)
        
        APIService.similarMovieSubject.single().subscribe { (event) in
            switch event {
            case .next(let movieArr):
                self.similarMovies.append(contentsOf: movieArr)
                self.refreshSubject.onNext(ReloadType.similarTableView)
                break
            case .error(let error):
                debugPrint(error)
                break
            case .completed:
                break
            }
        }.addDisposableTo(APIService.disposeBag)
    }
}
