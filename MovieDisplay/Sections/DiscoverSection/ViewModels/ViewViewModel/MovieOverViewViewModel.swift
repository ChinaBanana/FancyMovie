//
//  MovieOverViewVM.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/25.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation
import RxSwift

class MovieOverViewViewModel {
    
    var trailersArr:Array<TrailerItem>?
    var disposeBag = DisposeBag.init()
    var refreshSubject = PublishSubject<Array<TrailerItem>>()
    
    init() {
        APIService.subscribe({ (item) -> Bool in
            if let _ = item as? Array<TrailerItem> {
                return self.trailersArr == nil
            }
            return false
        }) { (trailers) in
            self.trailersArr = trailers as? Array<TrailerItem>
            self.refreshSubject.onNext(self.trailersArr!)
        }.addDisposableTo(disposeBag)
    }
    
    func request(_ id:Int) -> () {
        APIService.request(.getVideos(id))
    }
    
    func playVideo(_ index:Int) -> () {
        NavigatorService.playVideo(self.trailersArr![index])
    }
}
