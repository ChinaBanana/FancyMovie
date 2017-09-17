//
//  DiscoverCollectionViewCell.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(red: 246/255, green: 122/255, blue: 40/255, alpha: 1)
        nameLabel.layer.cornerRadius = 3
        nameLabel.clipsToBounds = true
        nameLabel.backgroundColor = mainColor
        nameLabel.font = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configContentView(_ item:MovieItem) -> () {
        imageView.kf.setImage(with: ImageUrl.standardImage(item.backdrop_path, type: .backdrop), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cachType, imageUrl) in
            
        }
        
        nameLabel.text = item.title
        if let text = item.title {
            nameLabel.snp.remakeConstraints({ (remake) in
                remake.left.bottom.equalTo(self.contentView)
                remake.height.equalTo(30)
                remake.width.equalTo(text.widthWithFont(self.nameLabel.font) + 20)
            })
        }
    }
}
