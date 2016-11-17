//
//  UIScrollView+Page.swift
//
//  Created by Chris Nevin on 18/11/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//
//  These methods assume pages are the full width of the scroll view and isPagingEnabled is true.
//

import UIKit

extension UIScrollView {

    /// Page with over 50% currently visible.
    var currentPage: Int {
        get {
            return Int((contentOffset.x + frame.width * 0.5) / frame.width)
        }
        set {
            contentOffset = CGPoint(x: frame.width * CGFloat(newValue), y: 0)
        }
    }

    /// Index of each visible page and the percentage, based on scroll width, that is visible.
    var visiblePages: [Int: CGFloat] {
        var pages = [Int: CGFloat]()
        let leftPageIndex = Int(contentOffset.x / frame.width)
        let rightPagePercentage = (contentOffset.x - frame.width * CGFloat(leftPageIndex)) / frame.width
        let leftPagePercentage = 1.0 - rightPagePercentage
        if leftPagePercentage > 0.0 {
            pages[leftPageIndex] = leftPagePercentage
        }
        
        let rightPageIndex = leftPageIndex + 1
        let totalWidthRequired = CGFloat(rightPageIndex + 1) * frame.width
        if totalWidthRequired <= contentSize.width, rightPagePercentage > 0.0 {
            pages[rightPageIndex] = rightPagePercentage
        }
        return pages
    }
    
}
