//
//  ItemListViewModel.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 17/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit

class ItemListViewModel {
    let discoverItem:DiscoverCellItem!
    
    init(_ item:DiscoverCellItem) {
        discoverItem = item
    }
    
    func navigateToMovieDetailViewController(_ index:Int) -> () {
        if let movie = discoverItem.array[index] as? MovieItem {
            let movieDetailCon = MovieDetailViewController.init(movie)
            NavigatorService.navigateToPage(movieDetailCon, animated: true)
        }else if let people = discoverItem.array[index] as? PeopleItem {
            let peopleDetailCon = PeopleDetailViewController.init(people)
            NavigatorService.navigateToPage(peopleDetailCon, animated: true)
        }
    }
}
