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
    var similarMoviesItem:DiscoverCellItem?
    var peoplesViewItem:PeopleOfMovieDetailItem?
    
    let refreshSubject = PublishSubject<ReloadType>()
    let disposeBag = DisposeBag.init()
    
    init() {
        NavigatorService.publishSubject.take(1).subscribe { (event) in
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
        }.addDisposableTo(disposeBag)
        
        // SimilarTableView Data
        APIService.similarMovieSubject.take(1).subscribe { (event) in
            switch event {
            case .next(let movieArr):
                self.similarMoviesItem = DiscoverCellItem.init("Movies", list: movieArr)
                self.refreshSubject.onNext(ReloadType.similarTableView)
                break
            case .error(let error):
                debugPrint("MovieDetailGetSimilarMovieSubjectError:\(error)")
                break
            case .completed:
                break
            }
        }.addDisposableTo(disposeBag)
        
        // Movie detail info
        APIService.subscribe({ (item) -> Bool in
            if let _ = item as? MovieDetailItem {
                return self.movieDetailItem == nil
            }
            return false
        }) { (movieDetail) in
            self.movieDetailItem = movieDetail as? MovieDetailItem
            self.refreshSubject.onNext(ReloadType.overview)
        }.addDisposableTo(disposeBag)
        
        // PeopleTableView Data
        APIService.subscribe({ (item) -> Bool in
            if let _ = item as? PeopleOfMovieDetailItem {
                return self.peoplesViewItem == nil
            }
            return false
        }) { (peoples) in
            self.peoplesViewItem = peoples as? PeopleOfMovieDetailItem
            self.refreshSubject.onNext(ReloadType.peopleTableView)
        }.addDisposableTo(disposeBag)
        
        
        
        
        // Trailers
        APIService.subscribe({ (item) -> Bool in
            
            return false
        }) { (videos) in
            
        }.addDisposableTo(disposeBag)
    }
}
