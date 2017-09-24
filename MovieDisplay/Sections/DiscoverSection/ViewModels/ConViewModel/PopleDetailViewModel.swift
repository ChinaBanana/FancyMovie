//
//  PopleDetailViewModel.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 17/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import Foundation
import RxSwift

class PeopleDetailViewModel {
    
    let refreshUISbujcet = PublishSubject<PeopleItem>()
    let disposeBag = DisposeBag.init()
    var people:PeopleItem?
    
    init() {
        NavigatorService.publishSubject.filter { (element) -> Bool in
            if let _ = element as? PeopleItem {
                return true
            }
            return false
            }.single().subscribe { (event) in
                switch event {
                case .next(let peopleItem):
                    self.people = peopleItem as? PeopleItem
                    self.refreshUISbujcet.onNext(peopleItem as! PeopleItem)
                    break
                case .error(let error):
                    debugPrint("PeopleDetailVMError:\(error)")
                    break
                case .completed:
                    break
                }
        }.addDisposableTo(disposeBag)
    }
}
