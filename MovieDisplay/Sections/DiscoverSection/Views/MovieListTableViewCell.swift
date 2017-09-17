//
//  MovieListTableViewCell.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 17/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    private let viewModel = MovieListTableViewCellViewModel()
    private let profileImage = UIImageView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let rateImage = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(rateImage)
        setContentViewLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentViewLayouts() {
        profileImage.snp.makeConstraints { (make) in
            
        }
        nameLabel.snp.makeConstraints { (make) in
            
        }
        dateLabel.snp.makeConstraints { (make) in
            
        }
        rateImage.snp.makeConstraints { (make) in
            
        }
    }
    
    func configCellContentWith(_ model:BaseModel) {
        
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
