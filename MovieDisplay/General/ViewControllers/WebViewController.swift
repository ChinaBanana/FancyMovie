//
//  WebViewController.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/14.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, UIWebViewDelegate{

    let webView = WKWebView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = view.bounds
        view.addSubview(webView)
    }
    
    func loadContentOfUrl(_ url:String) -> () {
        debugPrint("loadUrl:\(url)")
        let request = URLRequest.init(url: URL.init(string: url)!)
        webView.load(request)
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
//        debugPrint(webView.request?.url?.absoluteString)
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
