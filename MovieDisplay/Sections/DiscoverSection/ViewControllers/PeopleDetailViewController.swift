//
//  PeopleDetailViewController.swift
//  MovieDisplay
//
//  Created by 赵海伟 on 17/09/2017.
//  Copyright © 2017 cyt. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    
    private var viewModel:PeopleDetailViewModel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(_ people:PeopleItem) {
        self.init(nibName: nil, bundle: nil)
        viewModel = PeopleDetailViewModel.init(people)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainColor
        // Do any additional setup after loading the view.
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
