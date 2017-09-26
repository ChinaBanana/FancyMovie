//
//  VideoPlayerViewController.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/25.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import RxSwift

class VideoPlayerViewController: UIViewController {

    let playerView = YTPlayerView.init()
    let viewModel = VideoPlayerViewModel()
    var activityView:UIActivityIndicatorView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init () {
        self.init(nibName: nil, bundle: nil)
        viewModel.refreshSubject.subscribe { (event) in
            switch event {
            case .next(let trail):
                self.playerView.load(withVideoId: trail.key!)
                self.activityView.stopAnimating()
                break
            default: break
            }
        }.addDisposableTo(viewModel.disposeBag)
        
        activityView = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
        
        view.addSubview(playerView)
        view.addSubview(activityView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal, really fatal")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        playerView.stopVideo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        activityView.center = view.center
        playerView.frame = view.bounds
        activityView.startAnimating()
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
