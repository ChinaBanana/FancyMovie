//
//  MovieDetailViewController.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 17/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit
import RxSwift
import FDTemplateLayoutCell_swift

class MovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    private var viewModel = MovieDetailViewModel()
    private let backgroundView:UIScrollView = UIScrollView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let typeLabel = UILabel()
    private let segmentedBack = UIView()
    private let segmentedView = UISegmentedControl.init(items: ["Overview","People","Similar"])
    private let tableViewContainer = UIScrollView()
    private var overviewTableView = UITableView()
    private var peopleTableView = UITableView()
    private var similarTableView = UITableView()
    
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
        
        tableViewContainer.addSubview(overviewTableView)
        tableViewContainer.addSubview(peopleTableView)
        tableViewContainer.addSubview(similarTableView)
        tableViewContainer.isPagingEnabled = true
        tableViewContainer.delegate = self
        
        overviewTableView.delegate = self
        overviewTableView.dataSource = self
        overviewTableView.backgroundColor = UIColor.clear
        overviewTableView.separatorStyle = .none
        overviewTableView.isScrollEnabled = false
        overviewTableView.estimatedRowHeight = 100
        overviewTableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: "overviewCell")
        
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        peopleTableView.backgroundColor = UIColor.clear
        peopleTableView.separatorStyle = .none
        peopleTableView.isScrollEnabled = false
        peopleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "peopleCell")
        
        similarTableView.delegate = self
        similarTableView.dataSource = self
        similarTableView.backgroundColor = UIColor.clear
        similarTableView.separatorStyle = .none
        similarTableView.isScrollEnabled = false
        similarTableView.register(DiscoverTableViewCell.self, forCellReuseIdentifier: "itemCell")
        
        view.setNeedsUpdateConstraints()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == similarTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! DiscoverTableViewCell
            let item = DiscoverCellItem.init("Movies", list: viewModel.similarMovies)
            cell.configContenViewWith(item)
            return cell
        }else if tableView == peopleTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath) as! OverviewTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == overviewTableView {
            return 2
        }else if tableView == peopleTableView {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == overviewTableView {
            return tableView.fd_heightForCell(with: "overviewCell", configuration: { (cell) in
                
            })
        }else if tableView == peopleTableView {
            return tableView.fd_heightForCell(with: "peopleCell", configuration: { (cell) in
                
            })
        }
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
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl) {
        UIView.animate(withDuration: 0.2) {
            self.tableViewContainer.contentOffset = CGPoint.init(x: kScreenWidth * (CGFloat)(sender.selectedSegmentIndex), y: 0)
        }
    }
    
    private func bindUI() {
        viewModel.refreshSubject.subscribe { (event) in
            switch event {
            case .next(let reloadType):
                switch reloadType {
                case .overview:
                    let movieItem = self.viewModel.movieItem
                    self.profileImageView.kf.setImage(with: ImageUrl.standardImage(movieItem?.poster_path, type: .poster))
                    self.nameLabel.text = movieItem?.original_title
                    self.dateLabel.text = movieItem?.release_date
                    break
                case .peopleTableView:
                    self.peopleTableView.reloadData()
                    break
                case .similarTableView:
                    self.similarTableView.reloadData()
                    break
                }
                break
            case.error(let error):
                debugPrint(error)
                break
            case .completed:
                break
            }
        }.addDisposableTo(viewModel.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        tableViewContainer.contentSize = CGSize.init(width: kScreenWidth * 3, height: tableViewContainer.height)
        overviewTableView.frame = tableViewContainer.bounds
        peopleTableView.frame = tableViewContainer.bounds
        peopleTableView.left = kScreenWidth
        similarTableView.frame = tableViewContainer.bounds
        similarTableView.left = kScreenWidth * 2
        
        backgroundView.contentSize = CGSize.init(width: kScreenWidth, height: tableViewContainer.bottom)
        super.updateViewConstraints()
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
