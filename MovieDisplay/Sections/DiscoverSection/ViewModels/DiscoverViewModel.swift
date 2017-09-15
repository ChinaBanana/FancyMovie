//
//  DiscoverViewModel.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/13.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit
import RxSwift

class DiscoverViewModel {
    
    enum ReloadView {
        case CollectionView
        case TableView(Int)
    }
    
    let disposeBag = DisposeBag.init()
    let reloadSubject = PublishSubject<ReloadView>()
    
    var cycleItems:Array<MovieItem> = [MovieItem]()
    
    init() {
        APIService.discoverCycleSubject.subscribe { (event) in
            switch event {
            case .next(let items):
                self.cycleItems.removeAll()
                self.cycleItems.append(contentsOf: items)
                if let item = items.last {
                    self.cycleItems.insert(item, at: 0)
                    self.cycleItems.append(items[0])
                }
                self.reloadSubject.onNext(ReloadView.CollectionView)
                break
            default:
                break
            }
        }.addDisposableTo(disposeBag)
        requestDiscover(0)
    }
    
    func requestDiscover(_ page:Int) -> () {
        APIService.requestDiscover()
    }
}
