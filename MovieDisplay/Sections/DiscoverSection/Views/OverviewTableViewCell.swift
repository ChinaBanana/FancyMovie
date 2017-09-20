//
//  OverviewTableViewCell.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/20.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    
    lazy var summaryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCellWithModel(_ model:BaseModel) -> () {
        
    }
    
    private func configSummary() {
        
    }
    
    private func configTrailers() {
        
    }
    
    private func configFacts() {
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var height:CGFloat = 0
        height += nameLabel.sizeThatFits(size).height
        height += summaryLabel.sizeThatFits(size).height
        return CGSize.init(width: size.width, height: height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
