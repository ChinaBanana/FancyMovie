//
//  DiscoverTableViewCellViewModel.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 16/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import Foundation

class DiscoverTableViewCellViewModel {
    
    init() {
        
    }
    
    func navigateToMovieListView(_ contentItem:DiscoverCellItem?) -> () {
        if let item = contentItem {
            let viewCon = ItemListViewController.init(item)
            NavigatorService.navigateToPage(viewCon, animated: true)
        }
    }
}
