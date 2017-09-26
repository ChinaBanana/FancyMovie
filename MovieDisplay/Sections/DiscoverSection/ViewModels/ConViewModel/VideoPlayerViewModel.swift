//
//  VideoPlayerViewModel.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/25.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation
import RxSwift

class VideoPlayerViewModel {
    
    let disposeBag = DisposeBag.init()
    let refreshSubject = PublishSubject<TrailerItem>()
    
    init() {
        NavigatorService.publishSubject.filter { (item) -> Bool in
            if let _ = item as? TrailerItem {
                return true
            }
            return false
            }.subscribe { (event) in
                switch event {
                case .next(let trail):
                    self.refreshSubject.onNext(trail as! TrailerItem)
                    break
                default:
                    break
                }
        }.addDisposableTo(disposeBag)
    }
}
