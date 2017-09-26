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
    
    let movieDetailCon = MovieDetailViewController.init()
    let peopleDetailCon = PeopleDetailViewController.init()
    
    init(_ item:DiscoverCellItem) {
        discoverItem = item
    }
    
    func navigateToMovieDetailViewController(_ index:Int) -> () {
        if let movie = discoverItem.array[index] as? MovieItem {
            NavigatorService.navigateToPage(movieDetailCon, animated: true)
            NavigatorService.publish(movie)
        }else if let people = discoverItem.array[index] as? PeopleItem {
            NavigatorService.navigateToPage(peopleDetailCon, animated: true)
            NavigatorService.publish(people)
        }else if let cast = discoverItem.array[index] as? CastItem {
            NavigatorService.navigateToPage(peopleDetailCon, animated: true)
            NavigatorService.publish(cast)
        }else if let crew = discoverItem.array[index] as? CrewItem {
            NavigatorService.navigateToPage(peopleDetailCon, animated: true)
            NavigatorService.publish(crew)
        }
    }
}
