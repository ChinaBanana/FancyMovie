//
//  DiscoverTableViewCell.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit

let movieItemWidth = (kScreenWidth - 50) / 4

class DiscoverTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    private var movieListView:UICollectionView!
    private var contentItem:DiscoverCellItem?
    private let nameLabel = UILabel()
    private let seeAllBtn = UIButton()
    private let lineView = UIView()
    private let viewModel = DiscoverTableViewCellViewModel()
    private let itemWidth = movieItemWidth
    private let itemHeight = movieItemWidth * 138 / 92 + 35
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.black
        contentView.addSubview(nameLabel)
        contentView.addSubview(seeAllBtn)
        contentView.addSubview(lineView)
        contentView.backgroundColor = mainColor
        
        lineView.backgroundColor = UIColor.init(white: 0.2, alpha: 1)
        
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        seeAllBtn.setTitle("See All >", for: .normal)
        seeAllBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        seeAllBtn.setTitleColor(UIColor.init(red: 246/255, green: 122/255, blue: 40/255, alpha: 1), for: .normal)
        seeAllBtn.addTarget(self, action: #selector(seeAllBtnClicked), for: .touchUpInside)
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.headerReferenceSize = CGSize.init(width: 10, height: itemHeight)
        flowLayout.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        movieListView = UICollectionView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: kScreenWidth - 10, height: self.bounds.size.height)), collectionViewLayout: flowLayout)
        movieListView.delegate = self
        movieListView.dataSource = self
        movieListView.backgroundColor = UIColor.clear
        movieListView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: "movieCellId")
        contentView.addSubview(movieListView)
        setContentViewLayout()
    }
    
    @objc func seeAllBtnClicked() {
        self.viewModel.navigateToMovieListView(contentItem)
    }
    
    private func setContentViewLayout() {
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView)
            make.width.equalTo(150)
            make.height.equalTo(35)
        }
        seeAllBtn.snp.makeConstraints { (make) in
            make.right.top.equalTo(self.contentView)
            make.height.equalTo(nameLabel)
            make.width.equalTo(100)
        }
        movieListView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(nameLabel.snp.bottom)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.bottom.right.equalTo(contentView)
            make.height.equalTo(1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCellId", for: indexPath) as! MovieListCollectionViewCell
        cell.configConentView(contentItem?.array[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentItem?.array.count ?? 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configContenViewWith(_ item:DiscoverCellItem) -> () {
        nameLabel.text = item.name
        contentItem = item
        movieListView.reloadData()
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
