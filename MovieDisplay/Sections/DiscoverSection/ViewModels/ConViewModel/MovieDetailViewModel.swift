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
    var movieDetailItem:MovieDetailItem?
    var similarMovies:Array<BaseModel> = [BaseModel]()
    var peoplesViewItem:PeopleOfMovieDetailItem?
    
    let refreshSubject = PublishSubject<ReloadType>()
    let disposeBag = DisposeBag.init()
    
    init() {
        NavigatorService.publishSubject.filter { (model) -> Bool in
            if let _ = model as? MovieItem{
                return true
            }
            return false
            }.subscribe { (event) in
                switch event {
                case .next(let movieItem):
                    self.movieItem = movieItem as? MovieItem
                    APIService.request(.getSimilar((self.movieItem?.id)!))
                    APIService.request(.getMovieDetail((self.movieItem?.id)!))
                    APIService.request(.getMovieCredits((self.movieItem?.id)!))
                    APIService.request(.getVideos((self.movieItem?.id)!))
                    self.refreshSubject.onNext(ReloadType.overview)
                    break
                case.error(let error):
                    debugPrint("MovieDetailViewModelError:\(error)")
                    break
                case .completed:
                    break
                }
        }.addDisposableTo(NavigatorService.disposeBag)
        
        APIService.similarMovieSubject.subscribe { (event) in
            switch event {
            case .next(let movieArr):
                self.similarMovies.append(contentsOf: movieArr)
                self.refreshSubject.onNext(ReloadType.similarTableView)
                break
            case .error(let error):
                debugPrint("MovieDetailGetSimilarMovieSubjectError:\(error)")
                break
            case .completed:
                break
            }
        }.addDisposableTo(APIService.disposeBag)
        
        // 有bug 啊
        APIService.subscribe({ (item) -> Bool in
            if let _ = item as? MovieDetailItem {
                return true
            }
            return false
        }) { (movieDetail) in
            self.movieDetailItem = movieDetail as? MovieDetailItem
            self.refreshSubject.onNext(ReloadType.overview)
        }
        
        APIService.subscribe({ (item) -> Bool in
            if let _ = item as? PeopleOfMovieDetailItem {
                return true
            }
            return false
        }) { (peoples) in
            self.peoplesViewItem = peoples as? PeopleOfMovieDetailItem
            self.refreshSubject.onNext(ReloadType.peopleTableView)
        }
    }
}
