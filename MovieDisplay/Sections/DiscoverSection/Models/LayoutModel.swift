//
//  LayoutModel.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/21.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation
import UIKit

let margin:CGFloat = 15

struct BasicLayout : Layout {
    var left:CGFloat = 0
    var top:CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var right:CGFloat {
        set {
            top = newValue - height
        }
        get {
            return top + height
        }
    }
    var bottom:CGFloat {
        set {
            top = newValue - height
        }
        get {
            return top + height
        }
    }
    var frame:CGRect {
        set {
            left = newValue.origin.x
            top = newValue.origin.y
            right = newValue.origin.x + newValue.size.width
            bottom = newValue.origin.y + newValue.size.height
            width = newValue.size.width
            height = newValue.size.height
        }
        get {
            return CGRect.init(x: left, y: top, width: width, height: height)
        }
    }
}

struct OverviewLayout : Layout {
    
    private var _width:CGFloat = kScreenWidth
    private var _height:CGFloat = 0
    
    var left: CGFloat = 0
    var top: CGFloat = 0
    var plotSummaryLayout = BasicLayout()
    var summaryLayout = BasicLayout()
    var trailersLayout = BasicLayout()
    var trailersContentsLayout = BasicLayout()
    var movieFactsLayout = BasicLayout()
    var movieFactsContentsLayout = BasicLayout()
    
    var width: CGFloat {
        set {
            _width = newValue
        }
        get {
            return _width
        }
    }
    
    var height: CGFloat {
        set {
            _height = newValue
        }
        get {
            return _height
        }
    }
    
    var right: CGFloat {
        set {
            left = newValue - width
        }
        get {
            return width + left
        }
    }
    
    var bottom: CGFloat {
        set {
            top = newValue - height
        }
        get {
            return top + height
        }
    }
    
    init(_ item:Dictionary<String, Any>?) {
        
        plotSummaryLayout.left = margin
        plotSummaryLayout.width = kScreenWidth - margin * 2
        plotSummaryLayout.height = 30
        
        summaryLayout.left = margin
        summaryLayout.top = plotSummaryLayout.bottom
        summaryLayout.width = plotSummaryLayout.width
        
        if let summary = item?["overview"] as? String {
            summaryLayout.height = summary.heightWithLimit(CGSize.init(width: plotSummaryLayout.width, height: kScreenHeight), font: UIFont.systemFont(ofSize: 12))
            summaryLayout.height += margin
        }
        
        trailersLayout = plotSummaryLayout
        trailersLayout.top = summaryLayout.bottom
        
        trailersContentsLayout.left = trailersLayout.left
        trailersContentsLayout.width = trailersLayout.width
        trailersContentsLayout.height = 100
        trailersContentsLayout.top = trailersLayout.bottom
        
        movieFactsLayout = plotSummaryLayout
        movieFactsLayout.top = trailersContentsLayout.bottom
        
        movieFactsContentsLayout.left = movieFactsLayout.left
        movieFactsContentsLayout.top = movieFactsLayout.bottom
        movieFactsContentsLayout.width = movieFactsLayout.width
        movieFactsContentsLayout.height = 130
        
        _height += movieFactsContentsLayout.bottom
    }
}
