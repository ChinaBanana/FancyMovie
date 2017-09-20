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
    
    //
    enum ReloadView {
        case CollectionView
        case TableView
    }
    
    let disposeBag = DisposeBag.init()
    let reloadSubject = PublishSubject<ReloadView>()
    
    var cycleItems = [BaseModel]()
    var cellList = [DiscoverCellItem]()
    
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
        
        Observable.zip(APIService.popularMovieSubjcet, APIService.popularPeopleSubject, APIService.playingMovieSubject, APIService.upcomingMovieSubject, APIService.topRatedMovieSubject).subscribe { (event) in
            switch event {
            case .next(let element):
                self.cellList.removeAll()
                self.cellList.append(DiscoverCellItem.init("Popular Movies", list: element.0))
                self.cellList.append(DiscoverCellItem.init("Popular People", list: element.1))
                self.cellList.append(DiscoverCellItem.init("Now Playing", list: element.2))
                self.cellList.append(DiscoverCellItem.init("Upcoming", list: element.3))
                self.cellList.append(DiscoverCellItem.init("Top Rated", list: element.4))
                self.reloadSubject.onNext(ReloadView.TableView)
                break
            case .error(let error):
                debugPrint(error)
                break
            case .completed:
                break
            }
        }.addDisposableTo(disposeBag)
        
        APIService.request(.discover)
        APIService.request(.popularMovie)
        APIService.request(.popularPeople)
        APIService.request(.upcomingMovie)
        APIService.request(.topRatedMovie)
        APIService.request(.playingMovie)
    }
    
    public func navigateToDetailViewOfMovie(_ index:Int) {
        if let movieItem = cycleItems[index] as? MovieItem {
            let movieDetailCon = MovieDetailViewController()
            NavigatorService.navigateToPage(movieDetailCon, animated: true)
            NavigatorService.publish(movieItem)
        }
    }
}
