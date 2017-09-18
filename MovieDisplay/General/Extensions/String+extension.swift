//
//  String+extension.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

import UIKit

extension String {
    
    /**
     Get the width with the string.
     
     - parameter font: The font.
     
     - returns: The string's width.
     */
    func widthWithFont(_ font : UIFont) -> CGFloat {
        
        guard self.characters.count > 0 else {
            return 0
        }
        
        let size = CGSize.init(width: kScreenWidth - 40, height: 35)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return rect.size.width
    }
}
