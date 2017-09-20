//
//  DiscoverTableViewCellViewModel.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 16/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import Foundation

class DiscoverTableViewCellViewModel {
    
    var contentItem:DiscoverCellItem?
    
    init() {
        
    }
    
    func navigateToMovieListView() -> () {
        if let item = contentItem {
            let viewCon = ItemListViewController.init(item)
            NavigatorService.navigateToPage(viewCon, animated: true)
        }
    }
    
    func navigateToMovieDetail(_ index:Int) -> () {
        if let movie = contentItem?.array[index] as? MovieItem {
            let viewCon = MovieDetailViewController()
            NavigatorService.navigateToPage(viewCon, animated: true)
            NavigatorService.publish(movie)
        }else if let peopleItem = contentItem?.array[index] as? PeopleItem {
            let viewCon = PeopleDetailViewController()
            NavigatorService.navigateToPage(viewCon, animated: true)
            NavigatorService.publish(peopleItem)
        }
    }
}
