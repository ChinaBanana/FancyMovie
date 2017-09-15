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
    
    let viewModel = DiscoverViewModel()
    var tableView:UITableView!
    var tableHeaderView:UICollectionView!
    var timer:Timer!
    // 轮播图宽高比 300 ： 169
    let cycleImageWidth:CGFloat = kScreenWidth - 40
    let cycleImageHeight:CGFloat = (kScreenWidth - 40) * 169 / 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Discover"
        tableView = UITableView.init(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = mainColor
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
        Observable<Int>.interval(3.5, scheduler: MainScheduler.instance).subscribe { (event) in
            switch event {
            case .next(let index):
                let num = self.viewModel.cycleItems.count - 2
                let idx = index % num + 1
                let aIdx = CGFloat.init(idx)
                debugPrint(num, idx)
                UIView.animate(withDuration: 0.35, animations: {
                    self.tableHeaderView.contentOffset = CGPoint.init(x: self.cycleImageWidth * aIdx - 20, y: 0)
                }, completion: { (completion) in
                    if idx == num {
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
                    self.tableHeaderView.contentOffset = CGPoint.init(x: -20, y: 0)
                    break
                case .TableView(_):
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DiscoverCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cycleImageCell", for: indexPath) as! DiscoverCollectionViewCell
        cell.configContentView(self.viewModel.cycleItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.cycleItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint(viewModel.cycleItems[indexPath.row])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == tableHeaderView {
            
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
