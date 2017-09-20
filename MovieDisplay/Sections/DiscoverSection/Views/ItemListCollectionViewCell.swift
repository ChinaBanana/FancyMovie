//
//  ItemListCollectionViewCell.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 16/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit

class ItemListCollectionViewCell: UICollectionViewCell {
    
    private let imageContent = UIImageView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let viewModel = ItemListCollectionViewCellViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(imageContent)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        
        imageContent.contentMode = .scaleAspectFit
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = UIColor.init(white: 0.8, alpha: 0.5)
        dateLabel.font = nameLabel.font
        setLayouts()
    }
    
    private func setLayouts() {
        imageContent.snp.makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.right.top.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-35)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(imageContent)
            make.top.equalTo(imageContent.snp.bottom)
            make.height.equalTo(15)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom)
        }
    }
    
    public func configConentView(_ model:BaseModel?) {
        if let movieItem = model as? MovieItem {
            nameLabel.text = movieItem.title
            dateLabel.text = movieItem.release_date
            imageContent.kf.setImage(with: ImageUrl.thumbImage(movieItem.poster_path, type: .poster), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
                
            })
        }else if let peopleItem = model as? PeopleItem {
            nameLabel.text = peopleItem.name
            imageContent.kf.setImage(with: ImageUrl.standardImage(peopleItem.profile_path, type: .profile))
        }else {
            debugPrint("Can not recongise model:\(model!)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
