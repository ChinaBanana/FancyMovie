//
//  DiscoverTableViewCell.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let seeAllBtn = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(seeAllBtn)
        contentView.backgroundColor = mainColor
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView)
            make.width.equalTo(150)
            make.height.equalTo(35)
        }
        seeAllBtn.setTitle("See All >", for: .normal)
        seeAllBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        seeAllBtn.setTitleColor(UIColor.init(red: 246/255, green: 122/255, blue: 40/255, alpha: 1), for: .normal)
        seeAllBtn.snp.makeConstraints { (make) in
            make.right.top.equalTo(self.contentView)
            make.height.equalTo(nameLabel)
            make.width.equalTo(100)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configContenViewWith(_ item:DiscoverCellItem) -> () {
        nameLabel.text = item.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
