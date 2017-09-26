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
    private var overviewView = UIView()
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
        
        let share = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItems = [share]
        
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
        tableViewContainer.addSubview(peopleTableView)
        tableViewContainer.addSubview(similarTableView)
        tableViewContainer.isPagingEnabled = true
        tableViewContainer.delegate = self
        
        overviewView.backgroundColor = UIColor.clear
        
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        peopleTableView.backgroundColor = UIColor.clear
        peopleTableView.separatorStyle = .none
        peopleTableView.isScrollEnabled = false
        peopleTableView.register(DiscoverTableViewCell.self, forCellReuseIdentifier: "itemCell")
        
        similarTableView.delegate = self
        similarTableView.dataSource = self
        similarTableView.backgroundColor = UIColor.clear
        similarTableView.separatorStyle = .none
        similarTableView.isScrollEnabled = false
        similarTableView.register(DiscoverTableViewCell.self, forCellReuseIdentifier: "itemCell")
        
        view.setNeedsUpdateConstraints()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! DiscoverTableViewCell
        if tableView == similarTableView {
            cell.configContenViewWith(viewModel.similarMoviesItem)
        }else if tableView == peopleTableView {
            switch indexPath.row {
            case 0:
                let item = DiscoverCellItem.init("Cast", list: (viewModel.peoplesViewItem?.castItems)!)
                cell.configContenViewWith(item)
                break
            default:
                let item = DiscoverCellItem.init("Crew", list: (viewModel.peoplesViewItem?.crewItems)!)
                cell.configContenViewWith(item)
                break
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == peopleTableView {
            return viewModel.peoplesViewItem == nil ? 0 : 2
        }
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
                    
                    if let movieDetail = self.viewModel.movieDetailItem {
                        let overviewContentView = MovieOverView.init(movieDetail)
                        self.overviewView.addSubview(overviewContentView)
                        if let geners = movieDetail.genres {
                            var types = String()
                            for type in geners {
                                types.append("\(type.name!) ")
                            }
                            self.typeLabel.text = types
                        }
                    }
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
        overviewView.frame = tableViewContainer.bounds
        peopleTableView.frame = tableViewContainer.bounds
        peopleTableView.left = kScreenWidth
        similarTableView.frame = tableViewContainer.bounds
        similarTableView.left = kScreenWidth * 2
        
        backgroundView.contentSize = CGSize.init(width: kScreenWidth, height: tableViewContainer.bottom)
        super.updateViewConstraints()
    }
}

class MovieOverView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let plotLabel = UILabel()
    let summaryLable = UILabel()
    let trailersLabel = UILabel()
    var trailersContentView:UICollectionView!
    let movieFactsLabel = UILabel()
    let movieContentsLabel = UILabel()
    var viewModel:MovieOverViewViewModel = MovieOverViewViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        plotLabel.textColor = UIColor.white
        plotLabel.font = UIFont.systemFont(ofSize: 16)
        plotLabel.text = "Plot summary"
        
        trailersLabel.textColor = plotLabel.textColor
        trailersLabel.font = plotLabel.font
        trailersLabel.text = "Trailers"
        
        movieFactsLabel.textColor = plotLabel.textColor
        movieFactsLabel.font = plotLabel.font
        movieFactsLabel.text = "Movie Facts"
        
        summaryLable.textColor = plotLabel.textColor
        summaryLable.font = UIFont.systemFont(ofSize: 12)
        summaryLable.numberOfLines = 0
        
        movieContentsLabel.textColor = plotLabel.textColor
        movieContentsLabel.font = summaryLable.font
        movieContentsLabel.numberOfLines = 0
    }
    
    convenience init(_ item:MovieDetailItem) {
        self.init(frame: CGRect.init(x: 0, y: 0, width: item.layout.width, height: item.layout.height))
        plotLabel.frame = item.layout.plotSummaryLayout.frame
        summaryLable.text = item.overview
        summaryLable.frame = item.layout.summaryLayout.frame
        
        trailersLabel.frame = item.layout.trailersLayout.frame
        
        let flowlayout = UICollectionViewFlowLayout.init()
        flowlayout.itemSize = CGSize.init(width: (kScreenWidth - 30) / 3, height: item.layout.trailersContentsLayout.height)
        flowlayout.scrollDirection = .horizontal
        
        trailersContentView = UICollectionView.init(frame: item.layout.trailersContentsLayout.frame, collectionViewLayout: flowlayout)
        trailersContentView.delegate = self
        trailersContentView.dataSource = self
        trailersContentView.register(TrailsCollectionViewCell.self, forCellWithReuseIdentifier: "trailCell")
        trailersContentView.backgroundColor = UIColor.clear
        trailersContentView.setScreenWidthBottomLine()
        
        movieFactsLabel.frame = item.layout.movieFactsLayout.frame
        movieContentsLabel.frame = item.layout.movieFactsContentsLayout.frame
        movieContentsLabel.setScreenWidthBottomLine()
        movieContentsLabel.text = """
        Release date: \(item.release_date ?? "")
        
        Run time: \(item.runtime ?? 0)min
        
        Budget: $\(item.budget ?? 0)
        
        Revenue: $\(item.revenue ?? 0)
        """
        summaryLable.setScreenWidthBottomLine()
        
        addSubview(plotLabel)
        addSubview(summaryLable)
        addSubview(trailersLabel)
        addSubview(trailersContentView)
        addSubview(movieFactsLabel)
        addSubview(movieContentsLabel)
        
        viewModel.refreshSubject.subscribe { (event) in
            switch event {
            case .next(_):
                self.trailersContentView.reloadData()
                break
            default:
                break
            }
        }.addDisposableTo(viewModel.disposeBag)
        viewModel.request(item.id!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trailCell", for: indexPath) as! TrailsCollectionViewCell
        cell.configContents(viewModel.trailersArr?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.trailersArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.playVideo(indexPath.row)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("F***king init error")
    }
}
