//
//  PeopleDetailViewController.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 17/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    private let viewModel = PeopleDetailViewModel()
    private let backgroundView:UIScrollView = UIScrollView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let typeLabel = UILabel()
    private let segmentedBack = UIView()
    private let segmentedView = UISegmentedControl.init(items: ["Overview","Known for"])
    private let tableViewContainer = UIScrollView()
    private var overviewView = UIView()
    private var knownForTableView = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        bindUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainColor
        view.addSubview(backgroundView)
        
        backgroundView.frame = view.bounds
        backgroundView.backgroundColor = UIColor.clear
        backgroundView.delegate = self
        backgroundView.addSubview(profileImageView)
        backgroundView.addSubview(nameLabel)
        backgroundView.addSubview(typeLabel)
        backgroundView.addSubview(dateLabel)
        backgroundView.addSubview(tableViewContainer)
        backgroundView.addSubview(segmentedBack)
        
        segmentedBack.backgroundColor = mainColor
        segmentedBack.addSubview(segmentedView)
        
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        dateLabel.textColor = UIColor.init(white: 0.8, alpha: 0.5)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        typeLabel.textColor = dateLabel.textColor
        typeLabel.font = dateLabel.font
        
        segmentedView.backgroundColor = mainColor
        segmentedView.tintColor = UIColor.gray
        segmentedView.selectedSegmentIndex = 0
        segmentedView.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        tableViewContainer.addSubview(overviewView)
        tableViewContainer.addSubview(knownForTableView)
        tableViewContainer.isPagingEnabled = true
        tableViewContainer.delegate = self
        
        overviewView.backgroundColor = UIColor.clear
        
        knownForTableView.delegate = self
        knownForTableView.dataSource = self
        knownForTableView.separatorStyle = .none
        knownForTableView.backgroundColor = UIColor.clear
        knownForTableView.isScrollEnabled = false
        knownForTableView.register(DiscoverTableViewCell.self, forCellReuseIdentifier: "castCell")
    
        view.setNeedsUpdateConstraints()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! DiscoverTableViewCell
        if let knownforlist = viewModel.people?.known_for {
            let item = DiscoverCellItem.init("Cast", list: knownforlist)
            cell.configContenViewWith(item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (kScreenWidth - 50) / 4 * 138 / 92 + 70
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == backgroundView {
            if scrollView.contentOffset.y + 64 > profileImageView.bottom + 10{
                segmentedBack.top = scrollView.contentOffset.y + 64
            }else {
                segmentedBack.top = profileImageView.bottom + 10
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == tableViewContainer {
            let index = scrollView.contentOffset.x / kScreenWidth
            segmentedView.selectedSegmentIndex = Int.init(index)
        }
    }
    
    func bindUI() -> () {
//        viewModel.refreshUISbujcet.subscribe { (event) in
//            
//        }.addDisposableTo(viewModel.disposeBag)
        
        viewModel.refreshUISbujcet.subscribe(onNext: { (item) in
            self.profileImageView.kf.setImage(with: ImageUrl.standardImage(item.profile_path, type: .profile))
            self.nameLabel.text = item.name
            self.knownForTableView.reloadData()
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }) {
            
        }.addDisposableTo(viewModel.disposeBag)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl) {
        UIView.animate(withDuration: 0.2) {
            self.tableViewContainer.contentOffset = CGPoint.init(x: kScreenWidth * (CGFloat)(sender.selectedSegmentIndex), y: 0)
        }
    }
    
    override func updateViewConstraints() {
        profileImageView.frame = CGRect.init(x: 20, y: 20, width: 70, height: 70 * 138 / 92)
        nameLabel.frame = CGRect.init(x: profileImageView.right + 20, y: profileImageView.top, width: kScreenWidth - profileImageView.right - 40, height: 25)
        dateLabel.frame = CGRect.init(x: nameLabel.left, y: nameLabel.bottom, width: nameLabel.width, height: 20)
        typeLabel.frame = CGRect.init(x: dateLabel.left, y: dateLabel.bottom + 40, width: dateLabel.width, height: dateLabel.height)
        
        segmentedBack.frame = CGRect.init(x: 0, y: profileImageView.bottom + 10, width: kScreenWidth, height: 50)
        segmentedBack.setBottomLine()
        segmentedView.center = CGPoint.init(x: segmentedBack.width / 2, y: segmentedBack.height / 2)
        
        tableViewContainer.frame = CGRect.init(x: 0, y: segmentedBack.bottom, width: backgroundView.width, height: kScreenHeight - 160)
        tableViewContainer.contentSize = CGSize.init(width: kScreenWidth * 2, height: tableViewContainer.height)
        overviewView.frame = tableViewContainer.bounds
        knownForTableView.frame = tableViewContainer.bounds
        knownForTableView.left = kScreenWidth
        
        backgroundView.contentSize = CGSize.init(width: kScreenWidth, height: tableViewContainer.bottom)
        super.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
