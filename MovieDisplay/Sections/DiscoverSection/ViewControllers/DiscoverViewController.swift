//
//  DiscoverViewController.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/12.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit
import RxSwift

class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let refreshCon = UIRefreshControl()
    let viewModel = DiscoverViewModel()
    var tableView:UITableView!
    var tableHeaderView:UICollectionView!
    var cycleIndex:Int = 1
    var timer:Timer!
    let cycleImageWidth:CGFloat = kScreenWidth - 40
    let cycleImageHeight:CGFloat = (kScreenWidth - 40) * 169 / 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Discover"
        tableView = UITableView.init(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DiscoverTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = mainColor
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        let collectionViewLayout = UICollectionViewFlowLayout.init()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize.init(width: cycleImageWidth, height: cycleImageHeight)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        
        tableHeaderView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: cycleImageHeight), collectionViewLayout: collectionViewLayout)
        tableHeaderView.delegate = self
        tableHeaderView.dataSource = self
        tableHeaderView.register(DiscoverCollectionViewCell.self, forCellWithReuseIdentifier: "cycleImageCell")
        tableView.tableHeaderView = tableHeaderView
        
        // 轮播图
        Observable<Int>.interval(5.5, scheduler: MainScheduler.instance).subscribe { (event) in
            switch event {
            case .next(_):
                let num = self.viewModel.cycleItems.count - 2
                let aIdx = CGFloat.init(self.cycleIndex)
                UIView.animate(withDuration: 0.35, animations: {
                    self.tableHeaderView.contentOffset = CGPoint.init(x: self.cycleImageWidth * aIdx - 20, y: 0)
                }, completion: { (completion) in
                    self.cycleIndex += 1
                    if self.cycleIndex == num {
                        self.cycleIndex = 1
                        self.tableHeaderView.contentOffset = CGPoint.init(x: -20, y: 0)
                    }
                })
                break
            case .error(_):
                break
            case .completed:
                break
            }
        }.addDisposableTo(viewModel.disposeBag)
        
        viewModel.reloadSubject.subscribe { (event) in
            switch event {
            case .next(let reloadType):
                switch reloadType {
                case .CollectionView:
                    self.tableHeaderView.reloadData()
                    self.tableHeaderView.contentOffset = CGPoint.init(x: self.cycleImageWidth - 20, y: 0)
                    break
                case .TableView:
                    self.tableView.reloadData()
                    break
                }
                
                break
            default:
                break
            }
        }.addDisposableTo(viewModel.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DiscoverTableViewCell
        cell.configContenViewWith(viewModel.cellList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (kScreenWidth - 50) / 4 * 138 / 92 + 70
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DiscoverCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cycleImageCell", for: indexPath) as! DiscoverCollectionViewCell
        cell.configContentView(self.viewModel.cycleItems[indexPath.row] as! MovieItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.cycleItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.navigateToDetailViewOfMovie(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == tableHeaderView else {
            return
        }
        let index = (Int)(scrollView.contentOffset.x / cycleImageWidth) + 1
        if index >= viewModel.cycleItems.count - 2 {
            scrollView.setContentOffset(CGPoint.init(x: -20, y: 0), animated: false)
        }
        self.cycleIndex = index
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == tableHeaderView {
            self.cycleIndex = (Int)(scrollView.contentOffset.x / cycleImageWidth) + 1
            UIView.animate(withDuration: 0.2, animations: {
                scrollView.contentOffset = CGPoint.init(x: self.cycleImageWidth * (CGFloat)(self.cycleIndex) - 20, y: 0)
            })
        }
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
