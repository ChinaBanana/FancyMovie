//
//  TrailsCollectionViewCell.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/25.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit

class TrailsCollectionViewCell: UICollectionViewCell {
    
    let movieSnapShot = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        movieSnapShot.frame = self.bounds
        movieSnapShot.backgroundColor = UIColor.white
        
        contentView.addSubview(movieSnapShot)
        contentView.addSubview(nameLabel)
    }
    
    func configContents(_ item:TrailerItem?) -> () {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatel init error")
    }
}
