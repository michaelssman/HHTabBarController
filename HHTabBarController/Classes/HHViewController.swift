//
//  HHViewController.swift
//  HHObjectiveCDemo
//
//  Created by Michael on 2023/4/4.
//

import Foundation
import UIKit

extension UIViewController: UIScrollViewDelegate {
    
    private static var hh_scrollViewKey: Void?
    @objc var hh_scrollView: UIScrollView? {
        get {
            return objc_getAssociatedObject(self, &Self.hh_scrollViewKey) as? UIScrollView
        }
        set {
            objc_setAssociatedObject(self, &Self.hh_scrollViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            newValue?.delegate = self
        }
    }
    
    private static var hh_didScollHandlerKey: Void?
    var hh_didScollHandler: ((_ scrollView: UIScrollView) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &Self.hh_didScollHandlerKey) as? (UIScrollView) -> Void
        }
        set {
            objc_setAssociatedObject(self, &Self.hh_didScollHandlerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let hh_didScollHandler = hh_didScollHandler {
            hh_didScollHandler(scrollView)
        }
    }
    
//    @objc func hh_scrollView() -> UIScrollView? {
//        print("over")
//        return nil
//    }
}
