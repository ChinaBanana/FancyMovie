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
    private let lineView = UIView()
    private let imageWidth:CGFloat = 70
    private let imageHeight:CGFloat = 70 * 138 / 92
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(rateImage)
        contentView.addSubview(lineView)
        profileImage.contentMode = .scaleAspectFit
        nameLabel.textColor = UIColor.white
        lineView.backgroundColor = UIColor.init(white: 0.2, alpha: 1)
        dateLabel.textColor = UIColor.init(white: 0.8, alpha: 0.5)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        setContentViewLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentViewLayouts() {
        profileImage.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.height.equalTo(imageHeight)
            make.width.equalTo(imageWidth)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(profileImage.snp.right).offset(10)
            make.top.equalTo(contentView).offset(25)
            make.height.equalTo(25)
            make.right.equalTo(contentView).offset(-20)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.right.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom)
            make.height.equalTo(20)
        }
        rateImage.snp.makeConstraints { (make) in
            
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.right.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    func configCellContentWith(_ model:BaseModel?) {
        if let movie = model as? MovieItem {
            nameLabel.text = movie.title
            dateLabel.text = movie.release_date
            profileImage.kf.setImage(with: ImageUrl.thumbImage(movie.poster_path, type: .poster), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, catchType, url) in
                
            })
        } else if let people = model as? PeopleItem {
            nameLabel.text = people.name
            profileImage.kf.setImage(with: ImageUrl.standardImage(people.profile_path, type: .profile), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, catchType, url) in
                debugPrint(image?.size.width)
                debugPrint(image?.size.height)
            })
        }
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
