//
//  MovieListViewModel.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 17/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit

class MovieListViewModel {
    let movieListItem:DiscoverCellItem!
    
    init(_ item:DiscoverCellItem) {
        movieListItem = item
    }
    
    func navigateToMovieDetailViewController(_ index:Int) -> () {
        if let movie = movieListItem.array[index] as? MovieItem {
            let movieDetailCon = MovieDetailViewController.init(movie)
            NavigatorService.navigateToPage(movieDetailCon, animated: true)
        }
    }
}
