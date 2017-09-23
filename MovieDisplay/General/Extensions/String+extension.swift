//
//  String+extension.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit

extension String {
    
    func widthWithLimit(_ size:CGSize, font:UIFont) -> CGFloat {
        return sizeWithLimit(size, font: font).width
    }
    
    func heightWithLimit(_ size:CGSize, font:UIFont) -> CGFloat {
        return sizeWithLimit(size, font: font).height
    }
    
    func sizeWithLimit(_ size:CGSize, font:UIFont) -> CGSize {
        guard self.characters.count > 0 else {
            return CGSize.zero
        }
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil)
        return rect.size
    }
}
