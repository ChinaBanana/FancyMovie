//
//  ItemListViewController.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 16/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit
/**
 Discover 页面点击see all button 到这个页面
 可以展示 MovieList 或 PeopleList
 */
class ItemListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModel: ItemListViewModel!
    private var tableView: UITableView!
    
    // MARK: - life cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init (_ item:DiscoverCellItem) {
        self.init(nibName: nil, bundle: nil)
        viewModel = ItemListViewModel.init(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainColor
        self.navigationItem.title = viewModel.discoverItem.name
        tableView = UITableView.init(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemListTableViewCell.self, forCellReuseIdentifier: "listCell")
        tableView.backgroundColor = mainColor
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ItemListTableViewCell
        cell.configCellContentWith(viewModel.discoverItem.array[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.discoverItem.array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 * 138 / 92 + 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToMovieDetailViewController(indexPath.row)
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
